import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowWallpaperDialog {
  static void showSetWallpaperDialog(Function(String type) onSetWallpaper) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Blur background
        child: AlertDialog(
          backgroundColor: const Color(0xFF102220).withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: Colors.cyanAccent.withOpacity(0.2),
              width: 1,
            ),
          ),
          title: const Center(
            child: Text(
              "Set Wallpaper",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: 1.1,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Apply this to your device",
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 24),
              _dialogButton("Home Screen", Icons.home_rounded, () {
                Get.back();
                onSetWallpaper("home");
              }),
              const SizedBox(height: 12),
              _dialogButton("Lock Screen", Icons.lock_rounded, () {
                Get.back();
                onSetWallpaper("lock");
              }),
              const SizedBox(height: 12),
              _dialogButton("Both Screens", Icons.devices_rounded, () {
                Get.back();
                onSetWallpaper("both");
              }),
            ],
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _dialogButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: Colors.cyanAccent),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
