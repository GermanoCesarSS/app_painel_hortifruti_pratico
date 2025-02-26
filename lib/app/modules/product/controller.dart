import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/new_category/page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repository;
  ProductController(this._repository);

  final formKey = GlobalKey<FormState>();
  final loading = RxBool(false);

  final product = Rxn<ProductModel>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  final unitOfMeasure = RxString('UN');
  final image = Rxn<PlatformFile>();
  final currentImage = RxnString();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();
  final editing = RxBool(false);
  late String title;

  @override
  void onInit() {
    loadCategories();

    if (Get.arguments != null) {
      product.value = Get.arguments['product'];
      title = product.value!.name;
      editing.value = true;

      var _produto = product.value!;
      nameController.text = _produto.name;
      descriptionController.text = _produto.description ?? '';
      priceController.text = _produto.price.toString();
      unitOfMeasure.value = _produto.unitOfMeasure;
      categoryId.value = _produto.categpryId;
      currentImage.value = _produto.imagem;
    } else {
      title = 'Novo Produto';
    }

    super.onInit();
  }

  Future<void> loadCategories() async {
    await _repository.getCategories().then((data) {
      categoryList.assignAll(data);
    });
  }

  changeunitOfMeasure(String? value) {
    unitOfMeasure.value = value!;
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

  void onAdd() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var productRequest = ProductRequestModel(
      name: nameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      imagem: image.value,
    );
    loading.value = true;
    _repository.postProduct(productRequest).then((value) async {
      Get.back();
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }).whenComplete(() => loading.value = false);
  }

  void onUpdate() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    var productRequest = ProductRequestModel(
      id: product.value!.id,
      name: nameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      imagem: image.value,
    );

    loading.value = true;

    _repository.putProduct(productRequest).then((value) async {
      Get.back();
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }).whenComplete(() => loading.value = false);
  }

  void goToNewCategory() {
    Get.dialog(NewCategoryWidget());
  }
}
