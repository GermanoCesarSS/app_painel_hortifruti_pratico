// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class StoreRepository {
  final Api _api;

  StoreRepository(this._api);

  Future<StoreModel> getStore(int id) {
    return _api.getStore(id);
  }
}
