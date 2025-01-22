import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/widgets/category_detail/category_detail_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/widgets/category_list/category_list_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';

class CategoryListPage extends GetResponsiveView<CategoryListController> {
  CategoryListPage({super.key});

  @override
  Widget desktop() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: [
          TextButton(
            onPressed: () => Get.toNamed(Routes.product),
            child: Text('Novo Produto'),
          ),
        ],
      ),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: CategoryListWidget(onItemSelect: controller.chanceOrder),
            ),
          ),
          Flexible(flex: 3, child: OrderDetailWidget()),
        ],
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: CategoryListWidget(
        onItemSelect: (CategoryModel catetory) => Get.toNamed(Routes.catetory
            .replaceFirst(':category_id', catetory.id.toString())),
      ),
    );
  }
}
