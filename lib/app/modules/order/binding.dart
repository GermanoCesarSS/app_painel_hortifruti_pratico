import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_repository.dart';
import 'package:app_painel_hortifruti_pratico/app/widget/order/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
        () => OrderController(OrderRepository(Get.find<Api>())));
  }
}
