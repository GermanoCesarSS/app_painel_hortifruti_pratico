// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/modules/store/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/store_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () {
          if (controller.showCartButton == false) {
            return Container();
          }
          return FloatingActionButton(
            child: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed(Routes.cart),
          );
        },
      ),
      body: controller.obx(
        (state) => CustomScrollView(
          slivers: [
            const SliverAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.00,
                  top: 8.00,
                  right: 16.00,
                  bottom: 16.00,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 96.0,
                      height: 96.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: FadeInImage.memoryNetwork(
                          imageErrorBuilder: (context, error, stackTrace) =>
                              const SizedBox(
                            child: Icon(
                              Icons.local_convenience_store_rounded,
                              size: 80.0,
                              color: Colors.black,
                            ),
                          ),
                          placeholder: kTransparentImage,
                          image: state!.imagem,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.name,
                            style: Get.textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          StoreStatus(isOnline: state.isOnline),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(((context, index) {
                var category = state.categories[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.00, horizontal: 16.00),
                            child: Text(
                              category.name,
                              style: Get.textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var product in category.products)
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
                          'store': state,
                        }),
                      ),
                  ],
                );
              }), childCount: state.categories.length),
            )
          ],
        ),
      ),
    );
  }
}
