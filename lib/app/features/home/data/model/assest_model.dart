import 'package:athkari/app/features/home/domain/entity/assest_entity.dart';


class AssetsModel {
  final int id;
  final String name;
  final String label;
  final String contentType;
  final int size;
  final int downloadCount;
  final String browserDownloadUrl;

  AssetsModel({
    required this.id,
    required this.name,
    required this.label,
    required this.contentType,
    required this.size,
    required this.downloadCount,
    required this.browserDownloadUrl,
  });

  factory AssetsModel.fromJson(Map<String, dynamic> json) {
    return AssetsModel(
      id: json['id'],
      name: json['name'],
      label: json['label'] ?? '',
      contentType: json['content_type'],
      size: json['size'],
      downloadCount: json['download_count'],
      browserDownloadUrl: json['browser_download_url'],
    );
  }

  AssetsEntity toEntity() {
    return AssetsEntity(
      id: id,
      name: name,
      label: label,
      contentType: contentType,
      size: size,
      downloadCount: downloadCount,
      browserDownloadUrl: browserDownloadUrl,
    );
  }
}
