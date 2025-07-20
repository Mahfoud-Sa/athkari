import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubApiService {
  final String githubToken;
  final String owner = "Mahfoud-Sa";
  final String repo = "athkari";

  GitHubApiService({required this.githubToken});

  Future<List<Map<String, dynamic>>> listReleases() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repo/releases'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load releases: ${response.statusCode}');
    }
  }

  Future<String> getLatestReleaseVersion() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String tagName = data['tag_name'];
      return tagName.replaceFirst('v', ''); // Remove 'v' prefix if present
    } else {
      throw Exception('Failed to load latest release: ${response.statusCode}');
    }
  }

  Future<String> getLatestReleaseWithApk() async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> assets = data['assets'];

      // Find the first APK asset
      for (final asset in assets) {
        if (asset['name'].toString().toLowerCase().endsWith('.apk')) {
          return asset['browser_download_url'] as String;
        }
      }

      throw Exception('No APK asset found in the latest release');
    } else {
      throw Exception('Failed to load latest release: ${response.statusCode}');
    }
  }
}
