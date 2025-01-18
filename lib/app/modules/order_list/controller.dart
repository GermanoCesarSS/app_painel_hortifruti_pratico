import 'package:app_painel_hortifruti_pratico/app/core/utils/tags/nome_tag.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_controller.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController
    with StateMixin<List<OrderModel>> {
  final OrderListRepository _repository;
  final _authService = Get.find<AuthService>();
  final orderSelected = RxnString();

  OrderListController(this._repository);

  @override
  void onInit() {
    ever(_authService.user, (_) => loadOrders());

    loadOrders();

    super.onInit();
  }

  Future<void> loadOrders() async{
   await _repository.getOrders().then((data) {
      var status = data.isEmpty ? RxStatus.empty() : RxStatus.success();
      change(data, status: status);
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void chanceOrder(OrderModel order) {
    orderSelected.value = order.hashId;

    Get.find<OrderController>(
      tag: NomeTag().nomeTagOrderDetail,
    ).orderHashId.value = order.hashId;
    
  }
}
