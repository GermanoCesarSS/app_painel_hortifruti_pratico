
import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class ProductRepository {

final Api _api;

ProductRepository(this._api);

 Future<List<CategoryModel>> getCategories() => _api.getCategories();

}