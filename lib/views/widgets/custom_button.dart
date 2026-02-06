import 'package:flutter/material.dart';

/// A reusable translucent button for download & set wallpaper
/// Background fills as download progresses
class DownloadSetButton extends StatelessWidget {
  final bool isDownloading;
  final double downloadProgress; // 0.0 to 1.0
  final bool isDownloaded;

  /// Called when button is tapped in "Download" state
  final VoidCallback onDownload;

  /// Called when button is tapped in "Set Wallpaper" state
  final VoidCallback onSet;

  const DownloadSetButton({
    super.key,
    required this.isDownloading,
    required this.downloadProgress,
    required this.isDownloaded,
    required this.onDownload,
    required this.onSet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isDownloaded) {
          onDownload();
        } else {
          onSet();
        }
      },
      child: Stack(
        children: [
          // Background progress
          LayoutBuilder(
            builder: (context, constraints) {
              final width =
                  constraints.maxWidth * (isDownloading ? downloadProgress : 1);
              return Container(
                width: width,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),

          // Button overlay
          Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Text(
              isDownloading
                  ? "${(downloadProgress * 100).toStringAsFixed(0)}%"
                  : isDownloaded
                  ? "Set Wallpaper"
                  : "Download and Set Wallpaper",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
