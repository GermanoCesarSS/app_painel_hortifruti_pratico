import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<OrderModel> {
  final OrderRepository _repository;
  OrderController(this._repository);

  final orderHashId = RxnString();

  @override
  void onInit() {
    String? hashId = Get.parameters['hashId'];

    ever(orderHashId, (String? hashId) => loadOrder());
    
    if (hashId != null) {
      orderHashId.value = hashId;
    }

    super.onInit();
  }

  Future<void> loadOrder() async {
    String _hashId = orderHashId.value!;
    change(state, status: RxStatus.loading());

    await _repository.getOrder(_hashId).then(
      (data) {
        change(data, status: RxStatus.success());
      },
      onError: (error) {
        change(null, status: RxStatus.error(error.toString()));
      },
    );
  }

  Future<void> onSendStatus(int statusId) async {
    await _repository
        .postOrderStatus(id: orderHashId.value!, statusId: statusId)
        .then(
      (data) async {
        await loadOrder();

        await Get.find<OrderListController>().loadOrders();
      },
      onError: (error) {
        Get.dialog(
          AlertDialog(
            title: Text(error.toString()),
          ),
        );
      },
    );
  }
}
