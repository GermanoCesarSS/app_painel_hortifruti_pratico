import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class CategoryListRepository {
  final Api _api;

  CategoryListRepository(this._api);

  Future<List<CategoryModel>> getCategories() => _api.getCategories();
}
