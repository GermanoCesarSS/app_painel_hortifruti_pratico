import 'package:app_painel_hortifruti_pratico/app/core/utils/tags/nome_tag.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_controller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController
    with StateMixin<List<CategoryModel>> {
  final CategoryListRepository _repository;
  final _authService = Get.find<AuthService>();
  final itemSelected = RxnInt();

  CategoryListController(this._repository);

  @override
  void onInit() {
    ever(_authService.user, (_) => loadOrders());

    loadOrders();

    super.onInit();
  }

  Future<void> loadOrders() async {
    await _repository.getCategories().then((data) {
      var status = data.isEmpty ? RxStatus.empty() : RxStatus.success();
      change(data, status: status);
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void chanceOrder(CategoryModel category) {
    itemSelected.value = category.id;

    Get.find<CategoryController>(
      tag: NomeTag().nomeTagOrderDetail,
    ).categoryId.value = category.id;
  }
}
