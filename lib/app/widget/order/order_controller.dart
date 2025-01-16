import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController with StateMixin<OrderModel> {
  final OrderRepository _repository;
  OrderController(this._repository);

  final orderHashId = RxnString();

  @override
  void onInit() {
    String? hashId = Get.parameters['hashId'];

    if (hashId == null) {
      change(null, status: RxStatus.error("ID do pedido não encontrado."));
      return;
    }

    ever(orderHashId, (String? hashId) => loadOrder());

    orderHashId.value = hashId;

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
}
