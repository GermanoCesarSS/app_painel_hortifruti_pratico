import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/payment_method.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/shipping_by_city.module.dart';

class StoreModel {
  int id;
  String name;
  String imagem;
  bool isOnline;
  List<CategoryModel> categories;
  List<ShippingByCityModel> shippingByCity;
  List<PaymentMethodModel> paymentMethod;

  StoreModel({
    required this.id,
    required this.name,
    required this.imagem,
    required this.isOnline,
    required this.categories,
    required this.shippingByCity,
    required this.paymentMethod,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'],
        name: json['nome'],
        imagem: json['logo'] ?? '',
        isOnline: json['online'],
        categories: json['categorias'] == null
            ? []
            : List<CategoryModel>.from(
                json['categorias'].map((_) => CategoryModel.fromJson(_)),
              ),
        shippingByCity: json['cidades'] == null
            ? []
            : List<ShippingByCityModel>.from(
                json['cidades'].map((_) => ShippingByCityModel.fromJson(_)),
              ),
        paymentMethod: json['meios_pagamentos'] == null
            ? []
            : List<PaymentMethodModel>.from(
                json['meios_pagamentos']
                    .map((_) => PaymentMethodModel.fromJson(_)),
              ),
      );
}
