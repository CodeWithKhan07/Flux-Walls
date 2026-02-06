import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluxwalls/views/widgets/delete_dialog/delete_dialog.dart';
import 'package:get/get.dart';

import '../../view_models/controllers/download_screen_controller.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DownloadsController());

    return Scaffold(
      backgroundColor: const Color(0xFF102220),
      appBar: AppBar(
        title: const Text("My Downloads"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Obx(
          () => controller.isEditMode.value
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: controller.toggleEditMode,
                )
              : const SizedBox.shrink(),
        ),
        actions: [
          Obx(() {
            if (controller.downloadedWallpapers.isEmpty)
              return const SizedBox.shrink();

            if (controller.isEditMode.value) {
              final allSelected =
                  controller.selectedUrls.length ==
                  controller.downloadedWallpapers.length;
              return TextButton(
                onPressed: allSelected
                    ? controller.deselectAll
                    : controller.selectAll,
                child: Text(
                  allSelected ? "Deselect All" : "Select All",
                  style: const TextStyle(color: Colors.tealAccent),
                ),
              );
            }

            return TextButton(
              onPressed: controller.toggleEditMode,
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.tealAccent),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.tealAccent),
          );
        }

        if (controller.downloadedWallpapers.isEmpty) {
          return Center(
            child: Text(
              "No downloads yet",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white54),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.6,
          ),
          itemCount: controller.downloadedWallpapers.length,
          itemBuilder: (context, index) {
            final wallpaper = controller.downloadedWallpapers[index];

            return Obx(() {
              final isSelected = controller.selectedUrls.contains(
                wallpaper.onlineUrl,
              );

              return GestureDetector(
                onTap: () {
                  if (controller.isEditMode.value) {
                    controller.toggleSelection(wallpaper.onlineUrl);
                  } else {
                    controller.showSetDialog(wallpaper.localPath);
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image Container with Border Highlight
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: isSelected
                            ? Border.all(color: Colors.tealAccent, width: 3)
                            : Border.all(color: Colors.transparent, width: 0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(wallpaper.localPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Selection Overlay
                    if (controller.isEditMode.value)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? Colors.tealAccent
                              : Colors.white70,
                          size: 26,
                        ),
                      ),
                  ],
                ),
              );
            });
          },
        );
      }),
      // Bottom Delete Bar
      bottomNavigationBar: Obx(
        () => controller.selectedUrls.isNotEmpty && controller.isEditMode.value
            ? Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A3330),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => confirmDelete(context, controller),
                    icon: const Icon(Icons.delete),
                    label: Text(
                      "Delete ${controller.selectedUrls.length} Items",
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
