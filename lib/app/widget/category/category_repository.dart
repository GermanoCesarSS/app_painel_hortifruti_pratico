import 'package:app_painel_hortifruti_pratico/app/data/models/product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class CategoryRepository {
  final Api _api;

  CategoryRepository(this._api);

  Future<List<ProductModel>> getProducts(int hashId) => _api.getProducts(hashId);

}
