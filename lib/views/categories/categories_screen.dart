import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluxwalls/routes/app_routes.dart';
import 'package:get/get.dart';

class WallpaperCategory {
  final String name;
  final String imageUrl;

  WallpaperCategory({required this.name, required this.imageUrl});
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<WallpaperCategory> categories = [
    WallpaperCategory(
      name: 'Cars',
      imageUrl:
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Motorcycles',
      imageUrl:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c39?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Nature',
      imageUrl:
          'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Anime',
      imageUrl:
          'https://images.unsplash.com/photo-1668293750324-bd77c1f08ca9?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    WallpaperCategory(
      name: 'Abstract',
      imageUrl:
          'https://images.unsplash.com/photo-1541701494587-cb58502866ab?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Dark',
      imageUrl:
          'https://images.unsplash.com/photo-1550684848-fac1c5b4e853?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Cyberpunk',
      imageUrl:
          'https://images.unsplash.com/photo-1605810230434-7631ac76ec81?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Minimal',
      imageUrl:
          'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Amoled',
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Flowers',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    WallpaperCategory(
      name: 'Architecture',
      imageUrl:
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Aerial',
      imageUrl:
          'https://images.unsplash.com/photo-1508233620467-f79f1e317a05?q=80&w=1074&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    WallpaperCategory(
      name: 'Vector',
      imageUrl:
          'https://images.unsplash.com/photo-1574169208507-84376144848b?q=80&w=800',
    ),
    WallpaperCategory(
      name: 'Street',
      imageUrl:
          'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?q=80&w=800',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF102220),
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2, // Rectangular categories
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                RouteNames.categoriesWallpapers,
                arguments: category.name,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Category Image
                  CachedNetworkImage(
                    imageUrl: category.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.white10),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // Dark Gradient Overlay for text readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  // Category Name
                  Center(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
