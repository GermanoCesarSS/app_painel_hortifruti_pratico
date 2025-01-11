import 'package:app_painel_hortifruti_pratico/app/data/models/order_product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/informacao_linha.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/controller.dart';
import 'package:intl/intl.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedidos'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Get.offAllNamed(Routes.dashboard,
        //       arguments: DashboardMenuIndex.orders),
        // ),
      ),
      body: controller.obx(
        (state) => ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.00),
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state!.store.name,
                    style: Get.textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '#${state.hashId}',
                          style: Get.textTheme.titleMedium,
                        ),
                      ),
                      Text(
                          'Data: ${DateFormat("dd/MM/y 'às' HH:mm").format(state.createdAt)}')
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço de entrega'.toUpperCase(),
                    style: Get.textTheme.titleMedium,
                  ),
                  Text(state.enderecoCompleto),
                  const SizedBox(height: 16.0),
                  Text(
                    'Andamento do pedido'.toUpperCase(),
                    style: Get.textTheme.titleMedium,
                  ),
                  for (var status in state.statusList)
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
                  for (var orderProduct in state.productList)
                    ListTile(
                      title: Text(orderProduct.product.name),
                      leading: _buildProductQuantitity(orderProduct),
                      trailing: Text(NumberFormat.simpleCurrency()
                          .format(orderProduct.product.price)),
                    ),
                  InformacaoLinha(
                    titulo: 'Custo de entrega',
                    estiloTitulo: Get.textTheme.bodyMedium,
                    numero: state.deliveryCustoFormatado,
                    estiloNumero: Get.textTheme.bodyMedium,
                  ),
                  InformacaoLinha(
                    titulo: 'Total',
                    numero: state.totalPedido,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductQuantitity(OrderProductModel orderProduct) {
    return Text(
      NumberFormat.decimalPattern().format(orderProduct.quantity) +
          (orderProduct.product.isKg ? 'kg' : 'x'),
    );
  }
}
