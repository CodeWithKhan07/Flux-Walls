import 'package:flutter/services.dart';
import 'package:fluxwalls/data/network/network_api_service.dart';

import '../../utils/app_utils.dart';

class WallpaperRepository {
  final apiService = NetworkApiService();

  static const platform = MethodChannel('com.example.fluxwalls/wallpaper');

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
      await platform.invokeMethod('setWallpaper', {
        'path': path,
        'location': type.contains('home')
            ? 1
            : type.contains("lock")
            ? 2
            : 3,
      });
      AppUtils.showToast(
        "Wallpaper applied successfully \n The App Will Restart Now !",
      );
    } on PlatformException catch (e) {
      AppUtils.showToast("Failed to apply: ${e.message}");
    }
  }
}
