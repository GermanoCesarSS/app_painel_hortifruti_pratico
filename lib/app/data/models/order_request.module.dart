import 'package:app_painel_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/cart_product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/payment_method.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';

class OrderRequestModel {
  StoreModel store;
  PaymentMethodModel paymentMethod;
  List<CartProductModel> cartProducts;
  AddressModel address;
  String? observation;

  OrderRequestModel({
    required this.store,
    required this.paymentMethod,
    required this.cartProducts,
    required this.address,
    this.observation,
  });

  Map<String, dynamic> toJson() => {
        'estabelecimento_id': store.id,
        'meio_pagamento_id': paymentMethod.id,
        'endereco_id': address.id,
        'produtos':
            cartProducts.map((cartProducts) => cartProducts.toJson()).toList(),
        if (observation != null && observation!.trim().isNotEmpty)
          'observacao': observation,
      };
}
