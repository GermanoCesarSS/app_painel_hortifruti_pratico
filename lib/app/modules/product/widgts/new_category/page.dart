import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/new_category/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/new_category/reposiroty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryWidget extends StatelessWidget {
  NewCategoryWidget({super.key});

  final controller =
      Get.put(NewCategoryController(NewCategoryRepository(Get.find<Api>())));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nova Categoria'),
      scrollable: true,
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe o nome da categoria';
                }
                return null;
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: Text('Fechar')),
        Obx(
          () => TextButton(
              onPressed: controller.loading.isTrue ? null : controller.onSubmit,
              child: Text('Adicionar')),
        ),
      ],
    );
  }
}
