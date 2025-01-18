import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemSelectedCallback = void Function(OrderModel order);

class OrderListWidget extends StatelessWidget {
  final OrderListController _controller = Get.find<OrderListController>();
  final ItemSelectedCallback onItemSelect;

  OrderListWidget({required this.onItemSelect, super.key});

  @override
  Widget build(BuildContext context) {
    return _controller.obx(
      (state) => ListView(
        children: [
          for (var order in state!)
            Obx(
              () => ListTile(
                title: Text('#${order.hashId}'),
                subtitle: Text(order.createAtFormatado),
                trailing: Chip(label: Text(order.statusList.last.name)),
                onTap: () => onItemSelect(order),
                selected: _controller.orderSelected.value == order.hashId,
              ),
            ),
        ],
      ),
      onEmpty: const Center(
        child: Text('Você não recebeu nenhum pedido.'),
      ),
    );
  }
}
