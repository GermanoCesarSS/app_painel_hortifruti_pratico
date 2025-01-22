
import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class ProductRepository {

final Api _api;

ProductRepository(this._api);

 Future<List<CategoryModel>> getCategories() => _api.getCategories();

 Future<ProductModel> postProduct(ProductRequestModel produtoRequest) => _api.postProduct(produtoRequest);
 
 Future<ProductModel> putProduct(ProductRequestModel produtoRequest) => _api.putProduct(produtoRequest);

}