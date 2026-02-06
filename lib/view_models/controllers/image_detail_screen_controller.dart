import 'dart:developer';
import 'dart:io';

import 'package:fluxwalls/model/photosmodel/photos_model.dart';
import 'package:fluxwalls/repository/wallpaper_repository/wallpaper_repistory.dart';
import 'package:fluxwalls/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../utils/services/local_storage_service.dart';
import '../../views/widgets/setwallpaper_dialog/set_wallpaper_dialog.dart';
import 'download_screen_controller.dart';

class ImageDetailController extends GetxController {
  late PhotoModel photo;
  final repository = WallpaperRepository();
  RxBool isDownloading = false.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxBool isDownloaded = false.obs;
  String localFilePath = '';
  final storageService = LocalStorageService.instance;

  @override
  void onInit() {
    super.onInit();
    photo = Get.arguments;
    _checkIfAlreadyDownloaded(); // Check download status on initialization
  }

  void downloadWallpaper(String url) {
    if (isDownloaded.value) {
      log("Wallpaper already downloaded. Showing set dialog.");
      ShowWallpaperDialog.showSetWallpaperDialog((type) {
        setWallpaper(type);
      });
      return;
    }

    isDownloading.value = true;
    repository
        .downloadWallpaper(
          url,
          onProgress: (progress) {
            downloadProgress.value = progress;
          },
        )
        .then((value) async {
          isDownloading.value = false;
          isDownloaded.value = true;
          await storageService.saveWallpaperRecord(url, value);
          AppUtils.showToast("Wallpaper Downloaded Successfully");
          if (Get.isRegistered<DownloadsController>()) {
            Get.find<DownloadsController>().refreshDownloads();
          }
          //
          ShowWallpaperDialog.showSetWallpaperDialog((type) {
            setWallpaper(type);
          });
          localFilePath = value;
          log("Path $value");
        })
        .onError((error, stacktrace) {
          isDownloading.value = false;
          isDownloaded.value = false;
          AppUtils.showToast(error.toString());
        });
  }

  Future<void> _checkIfAlreadyDownloaded() async {
    final existingPath = await storageService.getLocalPathForUrl(
      photo.imageUrl,
    );
    if (existingPath != null && await File(existingPath).exists()) {
      log("Wallpaper already exists locally at: $existingPath");
      isDownloaded.value = true;
      localFilePath = existingPath;
    }
  }

  Future<void> setWallpaper(String type) async {
    await repository.setWallpaper(path: localFilePath, type: type);
  }
}
