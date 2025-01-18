import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/new_category/page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repository;
  ProductController(this._repository);

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  final image = Rxn<PlatformFile>();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();

  @override
  void onInit() {
    loadCategories();

    super.onInit();
  }

  Future<void> loadCategories() async {
    await _repository.getCategories().then((data) {
      categoryList.assignAll(data);
    });
  }

  changeCategory(int? categorySelected) {
    categoryId.value = categorySelected;
  }

  Future<void> pickImage() async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );

    if (picker != null && picker.files.isNotEmpty) {
      image.value = picker.files.first;
    }
  }

  void goToNewCategory() {
    Get.dialog(NewCategoryWidget());
  }
}
