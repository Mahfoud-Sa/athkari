import 'package:athkari/app/core/services/app_database_services.dart';
import 'package:athkari/app/core/services/github_releses_services.dart';
import 'package:athkari/app/features/daily_wered/data/modules/daily_werel_model.dart';
import 'package:athkari/app/features/esnaad/domain/entities/esnad_entity.dart';
import 'package:athkari/app/features/home/domain/entity/daily_wered_progress_entity.dart';
import 'package:athkari/app/features/home/domain/repository/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeRepositoryImp implements HomeRepository {
  final AppDataBaseServices _appDataBaseServices;
  final GitHubApiService _gitHubApiService;
  HomeRepositoryImp(this._appDataBaseServices, this._gitHubApiService);
  @override
  Future<DailyWeredProgressEntity> getDailyWeredProgress() async {
    int totalWered =
        await _appDataBaseServices.dailyWeredDao.getTotalDailyWered();
    int compeletedWered =
        await _appDataBaseServices.dailyWeredDao.getCompeletedDailyWered();

    return DailyWeredProgressEntity(
        totalWered: totalWered, compeletedWered: compeletedWered);
  }

  @override
  Future<int> resetDatabase(EsnadEntity esnad) {
    // TODO: implement resetDatabase
    throw UnimplementedError();
  }

  @override
  Future<PackageInfo> getCurrentPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Future<String> getUpdateAPK() {
    return _gitHubApiService.getLatestReleaseWithApk();
  }

  @override
  Future<bool> isUpdateAvailable() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String lastVersion =
          await _gitHubApiService.getLatestReleaseVersion();

      // Remove any non-numeric characters except dots (like 'v' prefix)
      final String currentVersion =
          packageInfo.version.replaceAll(RegExp(r'[^0-9.]'), '');
      final String latestVersion =
          lastVersion.replaceAll(RegExp(r'[^0-9.]'), '');

      // Split version numbers into parts
      final List<int> currentParts =
          currentVersion.split('.').map((e) => int.parse(e)).toList();
      final List<int> latestParts =
          latestVersion.split('.').map((e) => int.parse(e)).toList();

      // Compare version parts
      for (int i = 0; i < latestParts.length; i++) {
        // If current version doesn't have this part, consider it older
        if (i >= currentParts.length) return true;

        if (latestParts[i] > currentParts[i]) {
          return true;
        } else if (latestParts[i] < currentParts[i]) {
          return false;
        }
      }

      // If all parts are equal
      return false;
    } catch (e) {
      // Handle any errors (network, parsing, etc.)
      debugPrint('Error checking for update: $e');
      return false;
    }
  }
}
