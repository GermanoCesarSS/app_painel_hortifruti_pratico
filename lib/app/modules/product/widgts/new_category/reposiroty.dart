import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class NewCategoryRepository {
  final Api _api;

  NewCategoryRepository(this._api);

  Future<CategoryModel> postCategory(CategoryRequestModel categoryRequestModel) => _api.postCategory(categoryRequestModel);
}
