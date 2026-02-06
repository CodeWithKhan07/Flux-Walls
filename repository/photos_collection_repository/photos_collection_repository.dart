import 'package:fluxwalls/data/network/network_api_service.dart';
import 'package:fluxwalls/model/photos_collection_model/Photos_Collection_Model.dart';

class PhotosCollectionRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<PhotosCollectionModel> getPhotosCollection(int page) async {
    return await _apiService.getPhotosCollection(page);
  }

  Future<PhotosCollectionModel> getSearchedPhotos(
    String query,
    int page,
  ) async {
    return await _apiService.getSearchQuery(query, page);
  }
}
