import 'dart:io';

import 'package:ezyhr_mobile_apps/shared/constant/app_asset_constant.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../response/app_asset_res.dart';
import '../utils/common_util.dart';

class AssetAppService {
  static AssetAppService instance = AssetAppService._();
  AssetAppService._();
  factory AssetAppService() => instance;

  static final _storage = GetStorage();

  static const _appAsset = 'appAsset';
  static final assetGlobal = Rxn<List<AppAssetTemp>>();
  static final appDocDir = Rxn<Directory>();

  Future<void> getAppAsset() async {
    appDocDir.value = await getApplicationDocumentsDirectory();
    final pathSeparator = Platform.pathSeparator;

    assetGlobal.value = AppAssetEnum.values
        .map((e) => AppAssetTemp(e, true, e.pathDefault))
        .toList();

    final localRes = _storage.read(_appAsset);
    List<AppAssetStorage?>? locals;

    bool isUpdateLocal = false;

    for (final e in AppAssetEnum.values) {
      final local = CommonUtil.firstWhereEqStr(locals, (t) => t?.name, e.name);

      if (CommonUtil.isBlank(local)) {}
    }

    final valLocal = locals?.map((e) => appAssetStorageToJson(e!)).toList();
    _storage.write(_appAsset, valLocal);

    assetGlobal.value = assetGlobal.value?.map((e) {
      final local =
          CommonUtil.firstWhereEqStr(locals, (t) => t?.name, e.assetType.name);
      if (CommonUtil.isNotBlank(local)) {
        return AppAssetTemp(e.assetType, false, local!.path!);
      }
      return e;
    }).toList();
  }
}
