import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_models/controllers/download_screen_controller.dart';

void confirmDelete(BuildContext context, DownloadsController controller) {
  Get.dialog(
    AlertDialog(
      backgroundColor: const Color(0xFF1A3330),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: Colors.white10, width: 1),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.delete_sweep_rounded,
            color: Colors.redAccent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            "Delete Wallpapers",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to permanently remove ${controller.selectedUrls.length} wallpapers from your storage?",
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.white70, height: 1.5),
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () {
            // controller.toggleEditMode();
            Get.back();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.white54),
          child: const Text("Cancel"),
        ),
        // Delete Button
        ElevatedButton(
          onPressed: () {
            Get.back();
            controller.deleteSelected();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            foregroundColor: Colors.redAccent,
            elevation: 0,
            side: const BorderSide(color: Colors.redAccent, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Delete"),
        ),
      ],
    ),
    transitionCurve: Curves.easeInOutBack,
  );
}
