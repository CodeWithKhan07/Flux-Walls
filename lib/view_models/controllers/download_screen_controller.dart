import 'dart:developer';
import 'dart:io';

import 'package:fluxwalls/repository/wallpaper_repository/wallpaper_repistory.dart';
import 'package:fluxwalls/utils/services/local_storage_service.dart';
import 'package:fluxwalls/views/widgets/setwallpaper_dialog/set_wallpaper_dialog.dart';
import 'package:get/get.dart';

import '../../utils/app_utils.dart';

// Represents a single downloaded wallpaper with its URL and local path
class DownloadedWallpaper {
  final String onlineUrl;
  final String localPath;

  DownloadedWallpaper({required this.onlineUrl, required this.localPath});
}

class DownloadsController extends GetxController {
  final storageService = LocalStorageService.instance;
  final repository = WallpaperRepository();
  final RxList<String> selectedUrls = <String>[].obs;
  final RxBool isEditMode = false.obs; // State for edit mode
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    if (!isEditMode.value) {
      selectedUrls.clear(); // This hides the bottom bar automatically via Obx
    }
  }

  // A reactive list to hold the downloaded wallpapers
  final RxList<DownloadedWallpaper> downloadedWallpapers =
      <DownloadedWallpaper>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadDownloadedWallpapers();
    refreshDownloads();
  }

  void selectAll() {
    selectedUrls.value = downloadedWallpapers.map((w) => w.onlineUrl).toList();
  }

  void deselectAll() {
    selectedUrls.clear();
  }

  Future<void> deleteWallpaper(DownloadedWallpaper wallpaper) async {
    try {
      // 1. Delete the file from the device storage
      final file = File(wallpaper.localPath);
      if (await file.exists()) {
        await file.delete();
      }

      // 2. Remove the record from your database
      await storageService.removeWallpaperRecord(wallpaper.onlineUrl);

      // 3. Remove from the displayed list locally to update UI instantly
      downloadedWallpapers.removeWhere(
        (w) => w.localPath == wallpaper.localPath,
      );

      AppUtils.showToast("Wallpaper deleted");
      log("Deleted wallpaper: ${wallpaper.localPath}");
    } catch (e) {
      AppUtils.showToast("Failed to delete wallpaper");
      log("Error deleting wallpaper: $e");
    }
  }

  void toggleSelection(String url) {
    if (selectedUrls.contains(url)) {
      selectedUrls.remove(url);
    } else {
      selectedUrls.add(url);
    }
  }

  Future<void> deleteSelected() async {
    if (selectedUrls.isEmpty) return;

    try {
      isLoading.value = true;

      // 1. Get the current records to find file paths
      final records = await storageService.getDownloadedWallpapers();

      for (String url in selectedUrls) {
        // 2. Delete the physical file if it exists
        final path = records[url];
        if (path != null) {
          final file = File(path);
          if (await file.exists()) {
            await file.delete();
          }
        }
      }

      // 3. Batch remove from storage service
      await storageService.removeMultipleWallpaperRecords(selectedUrls);

      // 4. Update the local UI list
      downloadedWallpapers.removeWhere(
        (w) => selectedUrls.contains(w.onlineUrl),
      );

      // 5. Cleanup
      selectedUrls.clear();
      isEditMode.value = false;

      AppUtils.showToast("Deleted successfully");
    } catch (e) {
      log("Error deleting: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDownloads() async {
    // Renamed from loadDownloadedWallpapers
    isLoading.value = true;
    final records = await storageService.getDownloadedWallpapers();
    final validWallpapers = <DownloadedWallpaper>[];

    await Future.forEach(records.entries, (entry) async {
      final localPath = entry.value as String;
      if (await File(localPath).exists()) {
        validWallpapers.add(
          DownloadedWallpaper(onlineUrl: entry.key, localPath: localPath),
        );
      }
    });

    downloadedWallpapers.value = validWallpapers.reversed
        .toList(); // Show newest first
    isLoading.value = false;
  }

  /// Loads the list of wallpapers from local storage
  Future<void> loadDownloadedWallpapers() async {
    isLoading.value = true;
    final records = await storageService.getDownloadedWallpapers();
    final validWallpapers = <DownloadedWallpaper>[];

    // Use Future.forEach for asynchronous loop processing
    await Future.forEach(records.entries, (entry) async {
      final localPath = entry.value as String;
      // Check if the file actually still exists on the device
      if (await File(localPath).exists()) {
        validWallpapers.add(
          DownloadedWallpaper(onlineUrl: entry.key, localPath: localPath),
        );
      }
    });

    downloadedWallpapers.value = validWallpapers;
    isLoading.value = false;
  }

  /// Shows the dialog to set a wallpaper from the downloads screen
  void showSetDialog(String localPath) {
    ShowWallpaperDialog.showSetWallpaperDialog((type) {
      repository.setWallpaper(path: localPath, type: type);
    });
  }
}
