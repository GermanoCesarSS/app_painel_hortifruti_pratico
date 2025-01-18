// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetResponsiveView<ProductController> {
  ProductPage({super.key});

  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Produto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            if (screen.isPhone) ...[
              _buildForm(),
              _buildPickAndShowImage(),
              _buildButtonSubmit(),
            ] else ...[
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 800.0),
                  child: IntrinsicHeight(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildForm(),
                            _buildButtonSubmit(),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Flexible(child: _buildPickAndShowImage()),
                    ],
                  )),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Row _buildButtonSubmit() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Adcionar')),
          ),
        ),
      ],
    );
  }

  Form _buildForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(labelText: 'Nome'),
            validator: ((String? value) {
              if (value != null || value!.isEmpty) {
                return 'Informe o nome';
              }
              return null;
            }),
          ),
          TextFormField(
            controller: controller.descriptionController,
            decoration: InputDecoration(labelText: 'Descrição'),
            minLines: 1,
            maxLength: 3,
          ),
          Row(
            spacing: 16.0,
            children: [
              Flexible(
                child: TextFormField(
                  controller: controller.priceController,
                  decoration: InputDecoration(labelText: 'Preço'),
                  validator: (value) {
                    if (value != null || value!.isEmpty) {
                      return 'Informe o preço';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 150.00,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Preço'),
                  items: ['UN', 'KG']
                      .map((String unit) =>
                          DropdownMenuItem(value: unit, child: Text(unit)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          Obx(
            () => DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Categoria'),
              value: controller.categoryId.value,
              items: controller.categoryList
                  .map(
                    (category) => DropdownMenuItem<int>(
                      value: category.id,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
              validator: (int? value) {
                if (value == null) {
                  return 'Selecione uma categoria';
                }
                return null;
              },
              onChanged: controller.changeCategory,
            ),
          ),
          TextButton(
            onPressed: controller.goToNewCategory,
            child: Text('Criar uma nova Categoria'),
          ),
        ],
      ),
    );
  }

  Widget _buildPickAndShowImage() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Imagem do produto',
            style: Get.textTheme.bodyMedium,
          ),
        ),
        Obx(() {
          if (controller.image.value != null &&
              controller.image.value!.bytes != null) {
            return _buildProductImage(
                Image.memory(controller.image.value!.bytes!));
          }
          return SizedBox();
        }),
        Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 16.0,
          ),
          child: OutlinedButton(
            onPressed: controller.pickImage,
            child: Text('Selecionar uma imagem'),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(Widget image) {
    return Align(
      child: Container(
        constraints: BoxConstraints(maxHeight: 250.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: image,
        ),
      ),
    );
  }
}
