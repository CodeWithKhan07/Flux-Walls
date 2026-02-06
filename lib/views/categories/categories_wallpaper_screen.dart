import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../view_models/controllers/categories_wallpaper_controller.dart';

class CategoryWallpapersScreen extends StatelessWidget {
  const CategoryWallpapersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject controller - it will automatically use the arguments inside
    final controller = Get.put(CategoryWallpapersController());

    return Scaffold(
      backgroundColor: const Color(0xFF102220),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${controller.categoryName} Wallpapers",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.photos.isEmpty && controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scroll) {
            if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 300) {
              controller.fetchCategoryPhotos();
            }
            return false;
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: controller.photos.length,
            itemBuilder: (context, index) {
              final photo = controller.photos[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () =>
                      Get.toNamed(RouteNames.imageDetailpage, arguments: photo),
                  child: CachedNetworkImage(
                    imageUrl: photo.imageUrl ?? '',
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        const Icon(Icons.error, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
