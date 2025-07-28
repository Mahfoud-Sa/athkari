import 'package:athkari/app/features/home/domain/entity/release_assest_entity.dart';

class ReleaseAssetModel extends ReleaseAssetEntity {
  ReleaseAssetModel({
    required super.id,
    required super.name,
    required super.contentType,
    required super.size,
    required super.downloadCount,
    required super.downloadUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ReleaseAssetModel.fromJson(Map<String, dynamic> json) {
    return ReleaseAssetModel(
      id: json['id'],
      name: json['name'],
      contentType: json['content_type'],
      size: json['size'],
      downloadCount: json['download_count'],
      downloadUrl: json['browser_download_url'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
