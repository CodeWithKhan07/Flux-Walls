import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluxwalls/repository/photos_collection_repository/photos_collection_repository.dart';
import 'package:fluxwalls/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../model/photosmodel/photos_model.dart';

class DiscoverScreenController extends GetxController {
  final PhotosCollectionRepository photosRepository =
      PhotosCollectionRepository();
  RxBool isSearchBarOpen = false.obs;
  RxBool isSearchMode = false.obs;
  RxList<PhotoModel> photosList = <PhotoModel>[].obs;
  RxList<PhotoModel> searchResults = <PhotoModel>[].obs;
  int discoverPage = 1;
  int searchPage = 1;

  RxBool isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDiscoverPhotos();
  }

  void toggleSearchBar() {
    isSearchBarOpen.toggle();

    if (!isSearchBarOpen.value) {
      clearSearch();
    }
  }

  Future<void> getDiscoverPhotos() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final result = await photosRepository.getPhotosCollection(discoverPage);
      photosList.addAll(result.photos);
      discoverPage++;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchPhotos(String query) async {
    if (query.isEmpty) return;

    isSearchMode.value = true;
    searchPage = 1;
    searchResults.clear();

    await _loadMoreSearch(query);
  }

  Future<void> loadMoreSearch() async {
    if (!isSearchMode.value) return;
    await _loadMoreSearch(searchController.text.trim());
  }

  Future<void> _loadMoreSearch(String query) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      final result = await photosRepository.getSearchedPhotos(
        query,
        searchPage,
      );
      searchResults.addAll(result.photos);
      searchPage++;
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      searchPhotos(searchController.text.toString());
    } else {
      AppUtils.showToast("Search Cannot Be Empty");
    }
  }

  void clearSearch() {
    isSearchMode.value = false;
    searchResults.clear();
    searchController.clear();
  }

  // ───────── ACTIVE LIST ─────────
  List<PhotoModel> get activeList =>
      isSearchMode.value ? searchResults : photosList;
}
