import 'package:athkari/app/features/home/data/model/releases_assest_model.dart';
import 'package:athkari/app/features/home/domain/entity/release_entity.dart';


class ReleaseModel extends ReleaseEntity {
  ReleaseModel({
    required super.id,
    required super.tagName,
    required super.name,
    required super.htmlUrl,
    required super.body,
    required super.createdAt,
    required super.publishedAt,
    required super.targetCommitish,
    required List<ReleaseAssetModel> super.assets,
  });

  factory ReleaseModel.fromJson(Map<String, dynamic> json) {
    return ReleaseModel(
      id: json['id'],
      tagName: json['tag_name'],
      name: json['name'],
      htmlUrl: json['html_url'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
      publishedAt: DateTime.parse(json['published_at']),
      targetCommitish: json['target_commitish'],
      assets: (json['assets'] as List)
          .map((a) => ReleaseAssetModel.fromJson(a))
          .toList(),
    );
  }
}


