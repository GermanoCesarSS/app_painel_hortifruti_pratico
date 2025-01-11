// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class HomeRepository {
  final Api _api;

  HomeRepository(this._api);

  Api get api => _api;

  Future<List<StoreModel>> getStores(int cityId) => _api.getStores(cityId);
}
