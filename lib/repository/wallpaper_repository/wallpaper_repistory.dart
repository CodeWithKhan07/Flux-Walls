import 'dart:io';

import 'package:fluxwalls/data/network/network_api_service.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

import '../../utils/app_utils.dart';

class WallpaperRepository {
  final apiService = NetworkApiService();
  final wallpaperManager = WallpaperManagerPlus();

  /// Downloads a wallpaper and optionally reports progress
  Future<String> downloadWallpaper(
    String url, {
    Function(double progress)? onProgress,
  }) async {
    return await apiService.downloadSpecificPhoto(url, onProgress: onProgress);
  }

  /// Sets wallpaper based on type: "home", "lock", "both"
  Future<void> setWallpaper({
    required String path,
    required String type,
  }) async {
    try {
      File imageFile = File(path);
      int location;

      // Select location logic...
      location = type == 'home'
          ? WallpaperManagerPlus.homeScreen
          : type == 'lock'
          ? WallpaperManagerPlus.lockScreen
          : WallpaperManagerPlus.bothScreens;

      // 1. Give the UI a tiny gap to process dialog closure
      await Future.delayed(const Duration(milliseconds: 100));
      Future.microtask(() async {
        await WallpaperManagerPlus().setWallpaper(imageFile, location);
      });
      // await Future.delayed(const Duration(milliseconds: 300));
      // AppUtils.showToast("Wallpaper Applied Successfully");
    } catch (e) {
      AppUtils.showToast("Failed to apply wallpaper");
    }
  }
}
