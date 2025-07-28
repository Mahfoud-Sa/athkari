class ReleaseAssetEntity {
  final int id;
  final String name;
  final String contentType;
  final int size;
  final int downloadCount;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReleaseAssetEntity({
    required this.id,
    required this.name,
    required this.contentType,
    required this.size,
    required this.downloadCount,
    required this.downloadUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
