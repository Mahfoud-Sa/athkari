import 'package:athkari/app/features/home/domain/entity/assest_entity.dart';
import 'package:athkari/app/features/home/domain/entity/auther_entity.dart';

class ReleasesEntity {
  final int id;
  final String tagName;
  final String name;
  final String htmlUrl;
  final bool draft;
  final bool prerelease;
  final DateTime createdAt;
  final DateTime publishedAt;
  final String body;
  final AuthorEntity author;
  final List<AssetsEntity> assets;

  ReleasesEntity({
    required this.id,
    required this.tagName,
    required this.name,
    required this.htmlUrl,
    required this.draft,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.body,
    required this.author,
    required this.assets,
  });
}
