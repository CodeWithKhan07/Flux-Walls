import 'package:fluxwalls/model/photosmodel/photos_model.dart';

class PhotosCollectionModel {
  final int total;
  final List<PhotoModel> photos;

  PhotosCollectionModel({required this.total, required this.photos});

  factory PhotosCollectionModel.fromJson(Map<String, dynamic> json) {
    return PhotosCollectionModel(
      total: json['total'] ?? 0,
      photos: (json['results'] as List)
          .map((photo) => PhotoModel.fromJson(photo))
          .toList(),
    );
  }
}
