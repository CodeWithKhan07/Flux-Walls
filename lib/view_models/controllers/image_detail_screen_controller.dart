import 'dart:developer';

import 'package:fluxwalls/model/photosmodel/photos_model.dart';
import 'package:fluxwalls/repository/wallpaper_repository/wallpaper_repistory.dart';
import 'package:fluxwalls/utils/app_utils.dart';
import 'package:fluxwalls/views/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../views/widgets/setwallpaper_dialog/set_wallpaper_dialog.dart';
class ImageDetailController extends GetxController {
  late PhotoModel photo;
  final repository = WallpaperRepository();
  RxBool isDownloading = false.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxBool isDownloaded = false.obs;
  String localFilePath = '';
  void downloadWallpaper(String url) {
    isDownloading.value = true;
    repository
        .downloadWallpaper(url, onProgress: (progress) {
      downloadProgress.value= progress;
        },)
        .then((value) {
          isDownloading.value = false;
          isDownloaded.value=true;
          AppUtils.showToast("Wallpaper Downloaded Successfully");
          ShowWallpaperDialog.showSetWallpaperDialog((type) {
            setWallpaper(type);
          },);
          localFilePath = value;
          log("Path $value");
        })
        .onError((error, stacktrace) {
          isDownloading.value = false;
          isDownloaded.value=false;
          AppUtils.showToast(error.toString());
        });
  }
Future<void> setWallpaper(String type) async {
   await repository.setWallpaper(path: localFilePath, type: type);
}
  @override
  void onInit() {
    super.onInit();
    photo = Get.arguments;
  }
}
