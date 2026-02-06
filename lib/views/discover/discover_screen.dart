import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluxwalls/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../view_models/controllers/discover_screen_controller.dart';
import '../widgets/search_bar.dart';
import '../widgets/shimmer_widget.dart';

class DiscoverScreen extends StatelessWidget {
  DiscoverScreen({super.key});

  final DiscoverScreenController controller = Get.put(
    DiscoverScreenController(),
    permanent: true,
  );
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF102220),
      body: Obx(() {
        final list = controller.activeList;

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent - 300 &&
                !controller.isLoading.value) {
              controller.isSearchMode.value
                  ? controller.loadMoreSearch()
                  : controller.getDiscoverPhotos();
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: const Color(0xFF102220),
                centerTitle: true,
                title: controller.isSearchBarOpen.value
                    ? AppSearchWidget(
                        onSearch: () {
                          controller.onSearch(context);
                        },
                        controller: controller.searchController,
                        onSubmitted: controller.searchPhotos,
                        node: _searchFocusNode,
                      )
                    : const Text(
                        "Discover",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                actions: [
                  IconButton(
                    icon: Icon(
                      controller.isSearchBarOpen.value
                          ? Icons.close
                          : Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller.toggleSearchBar();
                      if (controller.isSearchBarOpen.value) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _searchFocusNode.requestFocus();
                        });
                      }
                    },
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final photo = list[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(
                            RouteNames.imageDetailpage,
                            arguments: photo,
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl: photo.imageUrl ?? '',
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                        ),
                      ),
                    );
                  }, childCount: list.length),
                ),
              ),

              if (controller.isLoading.value)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: buildShimmerLoading(),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
