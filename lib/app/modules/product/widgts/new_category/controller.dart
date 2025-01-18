import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/new_category/reposiroty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewCategoryController extends GetxController {
  final NewCategoryRepository _repository;
  NewCategoryController(this._repository);

  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController(text: 'Legumes');
  final loading = RxBool(false);

  void onSubmit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var categoryRequest = CategoryRequestModel(name: nameController.text);

    loading.value = true;

    _repository.postCategory(categoryRequest).then((category) async {
      final productController = Get.find<ProductController>();
      await productController.loadCategories();
      productController.changeCategory(category.id);

      Get.back();
    }, onError: (error) {
      Get.dialog(AlertDialog(
        title: Text(error.toString()),
      ));
    }).whenComplete(() => loading.value = false);
  }
}
