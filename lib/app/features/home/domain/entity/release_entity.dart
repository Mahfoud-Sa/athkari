import 'package:athkari/app/features/home/domain/entity/release_assest_entity.dart';

class ReleaseEntity {
  final int id;
  final String tagName;
  final String name;
  final String htmlUrl;
  final String body;
  final DateTime createdAt;
  final DateTime publishedAt;
  final String targetCommitish;
  final List<ReleaseAssetEntity> assets;

  ReleaseEntity({
    required this.id,
    required this.tagName,
    required this.name,
    required this.htmlUrl,
    required this.body,
    required this.createdAt,
    required this.publishedAt,
    required this.targetCommitish,
    required this.assets,
  });
}

