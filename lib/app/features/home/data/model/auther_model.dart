import 'package:athkari/app/features/home/domain/entity/auther_entity.dart';


class AuthorModel {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;

  AuthorModel({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
      htmlUrl: json['html_url'],
      type: json['type'],
    );
  }

  AuthorEntity toEntity() {
    return AuthorEntity(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      type: type,
    );
  }
}
