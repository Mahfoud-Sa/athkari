class AuthorEntity {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;

  AuthorEntity({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
  });
}
