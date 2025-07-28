import 'package:athkari/app/features/home/data/datasources/release_remote_datasources_imp.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  late ReleaseRemoteDataSorcesImp dataSource;

  setUp(() {
    dataSource = ReleaseRemoteDataSorcesImp(githubToken: ''); // token optional if public repo
  });

  test('listReleases should return a non-empty list of ReleaseModel', () async {
    final releases = await dataSource.listReleases();
    expect(releases, isNotEmpty);
    expect(releases.first, isA<ReleaseModel>());
    print('✔ listReleases fetched ${releases} items.');
  });

  test('getLatestRelease should return a release', () async {
  ReleaseModel release = await dataSource.getLatestRelease();
  expect(release, isA<ReleaseModel>());

  print('✔ Latest Release Details:');
  print('ID: ${release.id}');
  print('Tag Name: ${release.tagName}');
  print('Name: ${release.name}');
  print('HTML URL: ${release.htmlUrl}');
  print('Draft: ${release.draft}');
  print('Prerelease: ${release.prerelease}');
  print('Created At: ${release.createdAt}');
  print('Published At: ${release.publishedAt}');
  print('Body: ${release.body}');

  print('\n✔ Author:');
  print('ID: ${release.author.id}');
  print('Login: ${release.author.login}');
  print('Avatar URL: ${release.author.avatarUrl}');
  print('HTML URL: ${release.author.htmlUrl}');
  print('Type: ${release.author.type}');

  print('\n✔ Assets:');
  for (final asset in release.assets) {
    print('--- Asset ---');
    print('ID: ${asset.id}');
    print('Name: ${asset.name}');
    print('Label: ${asset.label}');
    print('Content Type: ${asset.contentType}');
    print('Size: ${asset.size} bytes');
    print('Download Count: ${asset.downloadCount}');
    print('Download URL: ${asset.browserDownloadUrl}');
  }
});


  test('getLatestReleaseWithApk should return APK download URL', () async {
    final apkUrl = await dataSource.getLatestReleaseWithApk();
    expect(apkUrl, isNotEmpty);
    expect(apkUrl.endsWith('.apk'), true);
    print('✔ APK download URL: $apkUrl');
  });
}
