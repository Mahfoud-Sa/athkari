

import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources.dart';
import 'package:athkari/app/features/home/data/datasources/release_remote_datasources_imp.dart';
import 'package:athkari/app/features/home/data/model/release_model.dart';
import 'package:athkari/app/features/home/domain/repository/releases_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ReleaseRepositoryImp implements ReleasesRepository {
  // final AppDataBaseServices _appDataBaseServices;
  final ReleaseRemoteDataSorcesImp _releaseRemoteDataSoucesImp;

  ReleaseRepositoryImp( this._releaseRemoteDataSoucesImp);
   @override
  Future<PackageInfo> getCurrentPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Future<String> getUpdateAPK() {
    return _releaseRemoteDataSoucesImp.getLatestReleaseWithApk();
  }

  @override
Future<bool> isUpdateAvailable(String currentVersion) async {
  try {
    final ReleaseModel latestRelease =
        await _releaseRemoteDataSoucesImp.getLatestRelease();

    // Remove non-numeric characters except dots (e.g., remove 'v' prefix)
    final String cleanedCurrentVersion =
        currentVersion.replaceAll(RegExp(r'[^0-9.]'), '');
    final String cleanedLatestVersion =
        latestRelease.tagName.replaceAll(RegExp(r'[^0-9.]'), '');

    final List<int> currentParts =
        cleanedCurrentVersion.split('.').map(int.parse).toList();
    final List<int> latestParts =
        cleanedLatestVersion.split('.').map(int.parse).toList();

    final int maxLength = latestParts.length > currentParts.length
        ? latestParts.length
        : currentParts.length;

    for (int i = 0; i < maxLength; i++) {
      final int current = i < currentParts.length ? currentParts[i] : 0;
      final int latest = i < latestParts.length ? latestParts[i] : 0;

      if (latest > current) return true;
      if (latest < current) return false;
    }

    return false; // Versions are equal
  } catch (e) {
    debugPrint('Error checking for update: $e');
    return false;
  }
}



}