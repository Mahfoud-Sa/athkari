import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubApiService {
  static Future<List<Map<String, dynamic>>> listReleases(
    String owner,
    String repo,
  ) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repo/releases'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        "Authorization": "token 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",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load releases: ${response.statusCode}');
    }
  }

  static Future<String> getLatestReleaseVersion(
    String owner,
    String repo,
  ) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String tagName = data['tag_name'];
      return tagName.replaceFirst('v', ''); // Remove 'v' prefix if present
    } else {
      throw Exception('Failed to load latest release: ${response.statusCode}');
    }
  }
}
