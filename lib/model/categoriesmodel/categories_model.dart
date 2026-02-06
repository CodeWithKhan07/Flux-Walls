class WallpaperCategory {
  final String title;
  final String searchQuery;
  final String coverImage;

  WallpaperCategory({
    required this.title,
    required this.searchQuery,
    required this.coverImage,
  });
}

// Global list for your Discover screen
final List<WallpaperCategory> categories = [
  WallpaperCategory(title: "Neon", searchQuery: "neon", coverImage: "assets/neon_cover.jpg"),
  WallpaperCategory(title: "Amoled", searchQuery: "amoled dark", coverImage: "assets/amoled_cover.jpg"),
  WallpaperCategory(title: "Abstract", searchQuery: "abstract", coverImage: "assets/abstract_cover.jpg"),
  WallpaperCategory(title: "Nature", searchQuery: "nature landscape", coverImage: "assets/nature_cover.jpg"),
];