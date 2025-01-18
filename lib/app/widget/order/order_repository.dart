import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api.dart';

class OrderRepository {
  final Api _api;

  OrderRepository(this._api);

  Future<OrderModel> getOrder(String hashId) => _api.getOrder(hashId);

  Future<void> postOrderStatus({required String id,required int statusId}) =>
      _api.postOrderStatus(id, statusId);
}
