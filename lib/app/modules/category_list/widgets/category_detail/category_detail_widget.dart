import 'package:app_painel_hortifruti_pratico/app/core/utils/tags/nome_tag.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final String _nomeTagController = NomeTag().nomeTagOrderDetail;

class OrderDetailWidget extends StatelessWidget {
  OrderDetailWidget({super.key});
  final _controler = Get.put(
    CategoryController(CategoryRepository(Get.find<Api>())),
    tag: _nomeTagController,
    permanent: true,
  );
  final _categoryListController = Get.find<CategoryListController>();

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (itemSelected) {
        if (itemSelected.value == null) {
          return Center(
            child: Text(
              'Clique em uma categoria ao lado para ver os produtos.',
            ),
          );
        }
        return CategoryWidget(tag: NomeTag().nomeTagOrderDetail);
      },
      _categoryListController.itemSelected,
    );
  }
}
