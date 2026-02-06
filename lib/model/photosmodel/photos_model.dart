class PhotoModel {
  final String id;
  final String title;
  final String downloadUrl;
  final String imageUrl;

  PhotoModel({
    required this.id,
    required this.title,
    required this.downloadUrl,
    required this.imageUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] ?? '',
      title: json['alt_description'] ?? 'Untitled Wallpaper',
      downloadUrl: json['links']['download_location'] ?? '',
      imageUrl: json['urls']['regular'] ?? '', // Standard URL for display
    );
  }
}
