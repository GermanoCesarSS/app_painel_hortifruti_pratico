import 'package:app_painel_hortifruti_pratico/app/data/models/product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_repository.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with StateMixin<List<ProductModel>> {
  final CategoryRepository _repository;
  CategoryController(this._repository);

  final categoryId = RxnInt();

  @override
  void onInit() {
    ever(categoryId, (_) => loadProducts());
    if (Get.currentRoute != '/' && Get.parameters.containsKey('category_id')) {
      categoryId.value = int.parse(Get.parameters['category_id']!);
    }
    

    super.onInit();
  }
  

  Future<void> loadProducts() async {
    int id = categoryId.value!;
    change(state, status: RxStatus.loading());

    await _repository.getProducts(id).then(
      (data) {
        if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      },
      onError: (error) {
        change(null, status: RxStatus.error(error.toString()));
      },
    );
  }
}
