class AssetsEntity {
  final int id;
  final String name;
  final String label;
  final String contentType;
  final int size;
  final int downloadCount;
  final String browserDownloadUrl;

  AssetsEntity({
    required this.id,
    required this.name,
    required this.label,
    required this.contentType,
    required this.size,
    required this.downloadCount,
    required this.browserDownloadUrl,
  });
}
