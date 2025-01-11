import 'package:app_painel_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_status.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/payment_method.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:intl/intl.dart';

class OrderModel {
  String hashId;
  StoreModel store;
  num value;
  num deliveryCost;
  AddressModel? address;
  PaymentMethodModel? paymentMethod;
  List<OrderProductModel> productList;
  List<OrderStatusModel> statusList;
  String? observation;
  DateTime createdAt;

  OrderModel({
    required this.hashId,
    required this.store,
    required this.value,
    required this.deliveryCost,
    required this.address,
    this.paymentMethod,
    required this.productList,
    required this.statusList,
    this.observation,
    required this.createdAt,
  });

  String get totalPedido => NumberFormat.simpleCurrency().format(value);
  String get deliveryCustoFormatado =>
      NumberFormat.simpleCurrency().format(deliveryCost);
  String get enderecoCompleto => address != null
      ? '${address!.street}, n: ${address!.number}, ${address!.neighborhood}'
      : '';

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        hashId: json['hash_id'],
        store: StoreModel.fromJson(json['estabelecimento']),
        value: double.parse(json['valor']),
        deliveryCost: double.parse(json['custo_entrega']),
        address: json['endereco'] == null
            ? null
            : AddressModel.fromJson(json['endereco']),
        paymentMethod: json['meio_pagamento'] == null
            ? null
            : PaymentMethodModel.fromJson(json['meio_pagamento']),
        productList: json['produtos'] == null
            ? []
            : List<OrderProductModel>.from(
                json['produtos']
                    .map((product) => OrderProductModel.fromJson(product)),
              ),
        statusList: json['pedido_status'] == null
            ? []
            : List<OrderStatusModel>.from(
                json['pedido_status']
                    .map((status) => OrderStatusModel.fromJson(status)),
              ),
        observation: json['observacao'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
