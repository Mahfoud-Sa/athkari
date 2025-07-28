import 'package:athkari/app/features/home/data/model/assest_model.dart';
import 'package:athkari/app/features/home/data/model/auther_model.dart';
import 'package:athkari/app/features/home/domain/entity/release_entity.dart';



class ReleaseModel {
  final int id;
  final String tagName;
  final String name;
  final String htmlUrl;
  final bool draft;
  final bool prerelease;
  final DateTime createdAt;
  final DateTime publishedAt;
  final String body;
  final AuthorModel author;
  final List<AssetsModel> assets;

  ReleaseModel({
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

  factory ReleaseModel.fromJson(Map<String, dynamic> json) {
    return ReleaseModel(
      id: json['id'],
      tagName: json['tag_name'],
      name: json['name'],
      htmlUrl: json['html_url'],
      draft: json['draft'],
      prerelease: json['prerelease'],
      createdAt: DateTime.parse(json['created_at']),
      publishedAt: DateTime.parse(json['published_at']),
      body: json['body'],
      author: AuthorModel.fromJson(json['author']),
      assets: (json['assets'] as List)
          .map((a) => AssetsModel.fromJson(a))
          .toList(),
    );
  }

  ReleasesEntity toEntity() {
    return ReleasesEntity(
      id: id,
      tagName: tagName,
      name: name,
      htmlUrl: htmlUrl,
      draft: draft,
      prerelease: prerelease,
      createdAt: createdAt,
      publishedAt: publishedAt,
      body: body,
      author: author.toEntity(),
      assets: assets.map((e) => e.toEntity()).toList(),
    );
  }
}
