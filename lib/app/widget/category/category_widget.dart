import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryController _controller;
  CategoryWidget({String? tag, super.key})
      : _controller = Get.find<CategoryController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return _controller.obx(
      (state) => ListView(
        children: [
          for (var product in state!)
            ListTile(
              title: Text(product.name),
              subtitle: Text(
                NumberFormat.simpleCurrency().format(product.price) +
                    (product.isKg ? '/KG' : ''),
              ),
              leading: ClipRRect(
                child: FadeInImage.memoryNetwork(
                  imageErrorBuilder: (context, error, stackTrace) =>
                      const SizedBox(
                    width: 56.00,
                    child: Icon(
                      Icons.apple,
                      color: Colors.redAccent,
                      size: 50.00,
                    ),
                  ),
                  placeholder: kTransparentImage,
                  image: product.imagem,
                ),
              ),
              onTap: () => Get.toNamed(Routes.product, arguments: {
                'product': product,
              }),
            ),
        ],
      ),
      onEmpty: Center(
        child: Text('Nenhum produto cadastrado na categoria'),
      ),
    );
  }
}
