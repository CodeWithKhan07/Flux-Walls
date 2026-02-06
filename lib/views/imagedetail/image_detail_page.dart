import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluxwalls/view_models/controllers/image_detail_screen_controller.dart';
import 'package:fluxwalls/views/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../widgets/setwallpaper_dialog/set_wallpaper_dialog.dart';

class ImageDetailPage extends StatelessWidget {
  ImageDetailPage({super.key});

  final ImageDetailController controller = Get.find<ImageDetailController>();

  @override
  Widget build(BuildContext context) {
    final photo = controller.photo;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          photo.title.trimRight().toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xFF102220),
      body: Stack(
        children: [
          // ───── Full-screen Hero Image ─────
          Hero(
            tag: photo.id,
            child: CachedNetworkImage(
              imageUrl: photo.imageUrl,
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),

          // ───── Gradient Overlay ─────
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            child: Obx(() {
              return DownloadSetButton(
                downloadProgress: controller.downloadProgress.value,
                isDownloaded: controller.isDownloaded.value,
                isDownloading: controller.isDownloading.value,
                onDownload: () {
                  controller.downloadWallpaper(photo.imageUrl);
                },
                onSet: () {
                  ShowWallpaperDialog.showSetWallpaperDialog((type) {
                    controller.setWallpaper(type);
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
