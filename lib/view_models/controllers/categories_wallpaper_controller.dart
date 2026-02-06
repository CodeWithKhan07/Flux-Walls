import 'package:get/get.dart';

import '../../model/photosmodel/photos_model.dart';
import '../../repository/photos_collection_repository/photos_collection_repository.dart';

class CategoryWallpapersController extends GetxController {
  final PhotosCollectionRepository photosRepository =
      PhotosCollectionRepository();

  RxList<PhotoModel> photos = <PhotoModel>[].obs;
  RxBool isLoading = false.obs;
  int currentPage = 1;

  // Get name from arguments
  final String categoryName = Get.arguments as String;

  @override
  void onInit() {
    super.onInit();
    fetchCategoryPhotos();
  }

  Future<void> fetchCategoryPhotos() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final result = await photosRepository.getSearchedPhotos(
        categoryName,
        currentPage,
      );
      photos.addAll(result.photos);
      currentPage++;
    } finally {
      isLoading.value = false;
    }
  }
}
