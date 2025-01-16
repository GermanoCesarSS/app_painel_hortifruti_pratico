import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final String _nomeTagController = 'detail';

class OrderDetailWidget extends StatelessWidget {
  OrderDetailWidget({super.key});
  final _controler = Get.put(
    OrderController(OrderRepository(Get.find<Api>())),
    tag: _nomeTagController,
    permanent: true,
  );
  final _orderListController = Get.find<OrderListController>();

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (orderSelected) {
        if (orderSelected.value == null) {
          return Center(
            child: Text(
              'Clique em um pedidio ao lado para ver os detalhes.',
            ),
          );
        }
        return _controler.obx((state) => OrderWidget(
              order: state!,
              tag: _nomeTagController,
            ));
      },
      _orderListController.orderSelected,
    );
  }
}
