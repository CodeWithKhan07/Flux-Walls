import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _storageKey = 'downloaded_wallpapers'; // Private constructor
  LocalStorageService._();

  static final LocalStorageService instance = LocalStorageService._();

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  /// Saves the record of a downloaded wallpaper.
  /// Maps the photo URL to its local file path.
  Future<void> saveWallpaperRecord(String photoUrl, String localPath) async {
    final prefs = await _prefs;
    final records = await getDownloadedWallpapers();
    records[photoUrl] = localPath;
    await prefs.setString(_storageKey, json.encode(records));
  }

  /// Retrieves the local path for a given photo URL.
  /// Returns null if no record is found.
  Future<String?> getLocalPathForUrl(String photoUrl) async {
    final records = await getDownloadedWallpapers();
    return records[photoUrl];
  }

  Future<void> removeMultipleWallpaperRecords(List<String> photoUrls) async {
    final prefs = await _prefs;
    final records = await getDownloadedWallpapers();

    for (String url in photoUrls) {
      records.remove(url);
    }

    await prefs.setString(_storageKey, json.encode(records));
  }

  Future<void> removeWallpaperRecord(String photoUrl) async {
    final prefs = await _prefs;
    final records = await getDownloadedWallpapers();
    if (records.containsKey(photoUrl)) {
      records.remove(photoUrl);
      await prefs.setString(_storageKey, json.encode(records));
    }
  }

  /// Gets all downloaded wallpaper records.
  Future<Map<String, dynamic>> getDownloadedWallpapers() async {
    final prefs = await _prefs;
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      return json.decode(jsonString);
    }
    return {};
  }
}
