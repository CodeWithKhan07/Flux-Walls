import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Request storage/media permissions based on Android SDK version
  static Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) return true; // iOS handled separately

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    List<Permission> permissionsToRequest = [];

    if (sdkInt >= 33) {
      // Android 13+: Use photos and videos instead of storage
      permissionsToRequest.add(Permission.photos);
      permissionsToRequest.add(Permission.videos);
    } else if (sdkInt >= 30) {
      // Android 11 and 12: scoped storage
      permissionsToRequest.add(
        Permission.storage,
      ); // may also use MANAGE_EXTERNAL_STORAGE if required
    } else {
      // Android 10 and below: legacy storage
      permissionsToRequest.add(Permission.storage);
    }

    final statuses = await permissionsToRequest.request();

    // Check if all requested permissions are granted
    bool allGranted = statuses.values.every((status) => status.isGranted);

    // If any are permanently denied, open app settings
    statuses.forEach((permission, status) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    });

    return allGranted;
  }
}
