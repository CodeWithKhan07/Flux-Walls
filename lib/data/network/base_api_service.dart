import 'package:fluxwalls/model/photos_collection_model/Photos_Collection_Model.dart';

abstract class BaseApiService {
  Future<PhotosCollectionModel> getPhotosCollection(int page);

  Future<PhotosCollectionModel> getSearchQuery(String query, int page);

  Future<dynamic> getSpecificPhoto(String photoId);

  Future<String> downloadSpecificPhoto(
    String url, {
    Function(double progress)? onProgress,
  });
}
