import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/informacao_linha.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final OrderController _controller;
  OrderWidget({required this.order, required String tag, super.key})
      : _controller = Get.find<OrderController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.00),
          child: Column(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${order.hashId}',
                      style: Get.textTheme.titleMedium,
                    ),
                  ),
                  Text('Data: ${order.createAtFormatado}')
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Endereço de entrega'.toUpperCase(),
                style: Get.textTheme.titleMedium,
              ),
              Text(order.enderecoCompleto),
              const SizedBox(height: 16.0),
              Text(
                'Andamento do pedido'.toUpperCase(),
                style: Get.textTheme.titleMedium,
              ),
              for (var status in order.statusList)
                ListTile(
                  title: Text(status.name),
                  trailing: Text(
                    DateFormat.Hm().format(status.createAt),
                  ),
                ),
              Text(
                'Produtos'.toUpperCase(),
                style: Get.textTheme.titleMedium,
              ),
              for (var orderProduct in order.productList)
                ListTile(
                  title: Text(orderProduct.product.name),
                  leading: _buildProductQuantitity(orderProduct),
                  trailing: Text(NumberFormat.simpleCurrency()
                      .format(orderProduct.product.price)),
                ),
              InformacaoLinha(
                titulo: 'Custo de entrega',
                estiloTitulo: Get.textTheme.bodyMedium,
                numero: order.deliveryCustoFormatado,
                estiloNumero: Get.textTheme.bodyMedium,
              ),
              InformacaoLinha(
                titulo: 'Total',
                numero: order.totalPedido,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductQuantitity(OrderProductModel orderProduct) {
    return Text(
      NumberFormat.decimalPattern().format(orderProduct.quantity) +
          (orderProduct.product.isKg ? 'kg' : 'x'),
    );
  }
}
