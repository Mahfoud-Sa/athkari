import 'dart:convert';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:http/http.dart' as http;

class ReleaseRemoteDataSorcesImp implements ReleaseRemoteDataSource{
  final String githubToken;
  final String owner = "Mahfoud-Sa";
  final String repo = "athkari";

  ReleaseRemoteDataSorcesImp({required this.githubToken});

  @override
  Future<List<ReleaseModel>> listReleases() async {
  final response = await http.get(
    Uri.parse('https://api.github.com/repos/$owner/$repo/releases'),
    headers: {
      'Accept': 'application/vnd.github.v3+json',
      // 'Authorization': 'token $githubToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data
        .map((jsonItem) => ReleaseModel.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load releases: ${response.statusCode}');
  }
}


@override
Future<ReleaseModel> getLatestRelease() async {
  final response = await http.get(
    Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
    headers: {
      'Accept': 'application/vnd.github.v3+json',
      // 'Authorization': 'token $githubToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return ReleaseModel.fromJson(data);
  } else {
    throw Exception('Failed to load latest release: ${response.statusCode}');
  }
}

  @override
  Future<String> getLatestReleaseWithApk() {
    // TODO: implement getLatestReleaseWithApk
    throw UnimplementedError();
  }


  // @override
  // Future<ReleaseModel> getLatestReleaseWithApk() async {
  //   final response = await http.get(
  //     Uri.parse('https://api.github.com/repos/$owner/$repo/releases/latest'),
  //     headers: {
  //       'Accept': 'application/vnd.github.v3+json',
  //     //  'Authorization': 'token $githubToken',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     final List<dynamic> assets = data['assets'];

  //     // Find the first APK asset
  //     for (final asset in assets) {
  //       if (asset['name'].toString().toLowerCase().endsWith('.apk')) {
  //         return asset['browser_download_url'] as String;
  //       }
  //     }

  //     throw Exception('No APK asset found in the latest release');
  //   } else {
  //     throw Exception('Failed to load latest release: ${response.statusCode}');
  //   }
  // }


}
