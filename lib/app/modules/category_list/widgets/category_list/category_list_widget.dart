import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemSelectedCallback = void Function(CategoryModel category);

class CategoryListWidget extends StatelessWidget {
  final CategoryListController _controller = Get.find<CategoryListController>();
  final ItemSelectedCallback onItemSelect;

  CategoryListWidget({required this.onItemSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return _controller.obx(
      (state) => ListView(
        children: [
          for (var category in state!)
            Obx(
              () => ListTile(
                title: Text(category.name),
                onTap: () => onItemSelect(category),
                selected: _controller.itemSelected.value == category.id,
              ),
            ),
        ],
      ),
    );
  }
}
