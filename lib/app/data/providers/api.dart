import 'dart:convert';

import 'package:app_painel_hortifruti_pratico/app/data/models/address.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/city.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_address_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_response.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_profile_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/providers/api_interceptors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Api extends GetxService {
  final noAuthPaths = [
    '/cidades/1/estabelecimentos',
  ];
  final _baseUrl = 'http://localhost:3333/';
  late Dio _dio;

  @override
  void onInit() {
    debugPrint('--API @override void onInit()');
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      receiveTimeout: Duration(seconds: 16000),
      connectTimeout: Duration(seconds: 16000),
      sendTimeout: Duration(seconds: 16000),
    ));

    _dio.interceptors.add(AppInterceptors(_dio));

    super.onInit();
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    String nomeFn =
        'Future<UserLoginResponseModel> login(UserLoginRequestModel data) async';
    var response = await _dio.post('login', data: data.toJson());
    return UserLoginResponseModel.fromJson(response.data);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    String nomeFn =
        'Future<UserModel> register(UserProfileRequestModel data) async';
    var response = await _dio.post('cliente/cadastro', data: data.toJson());
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUser() async {
    String nomeFn = 'getUser() async';
    var response = await _dio.get('auth/me');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    String nomeFn =
        'Future<UserModel> putUser(UserProfileRequestModel data) async';
    var response = await _dio.get('cliente');

    return UserModel.fromJson(response.data);
  }

  Future<List<StoreModel>> getStores(int cityId) async {
    String nomeFn = 'Future<List<StoreModel>> getStores()';
    var response = (await _dio.get('cidades/$cityId/estabelecimentos'));

    List<StoreModel> data = [];
    for (var store in response.data) {
      data.add(StoreModel.fromJson(store));
    }
    debugPrint('---$nomeFn List<StoreModel> data: $data');
    // return (response.data as List).map((store) => StoreModel.fromJson(store)).toList();
    return data;
  }

  Future<StoreModel> getStore(int id) async {
    String nomeFn = 'Future<StoreModel> getStore(int id) async';
    var response = (await _dio.get('estabelecimentos/$id'));
    return StoreModel.fromJson(response.data);
  }

  Future<List<AddressModel>> getUserAddresses() async {
    String nomeFn = 'getUserAddress() async';
    var response = await _dio.get('enderecos');

    List<AddressModel> data = [];
    for (var address in response.data) {
      data.add(AddressModel.fromJson(address));
    }
    debugPrint('---$nomeFn List<AddressModel> data: $data');

    return data;
  }

  Future<List<CityModel>> getCities() async {
    String nomeFn = 'getCities() async';
    var response = await _dio.get('cidades');

    List<CityModel> data = [];
    for (var city in response.data) {
      data.add(CityModel.fromJson(city));
    }
    debugPrint('---$nomeFn List<CityModel> data: $data');

    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    String nomeFn =
        'Future<void> postAddress(UserAddressRequestModel data) async';
    await _dio.post('enderecos', data: data.toJson());
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    String nomeFn =
        'Future<void> putAddress(UserAddressRequestModel data) async';
    await _dio.put('enderecos/${data.id}', data: data.toJson());
  }

  Future<void> deleteAddress(int id) async {
    String nomeFn = 'Future<void> deleteAddress(int id) async';
    await _dio.delete('enderecos/$id');
  }

  Future<List<CategoryModel>> getCategories() async {
    String nomeFn = 'getCategories() async';
    var response = await _dio.get('estabelecimento/categorias');

    return (response.data as List)
        .map((orders) => CategoryModel.fromJson(orders))
        .toList();
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    String nomeFn = 'getProducts(int categoryId async';
    var response = await _dio.get('estabelecimento/produtos',
        queryParameters: {'categoria_id': categoryId});

    return (response.data as List)
        .map((orders) => ProductModel.fromJson(orders))
        .toList();
  }

  Future<CategoryModel> postCategory(CategoryRequestModel data) async {
    var response =
        await _dio.post('estabelecimento/categorias', data: jsonEncode(data));
    return CategoryModel.fromJson(response.data);
  }

  // PEDIDOS

  Future<String> postOrder(OrderRequestModel data) async {
    String nomeFn = 'postOrder() async';
    var response = await _dio.post('pedidos', data: data.toJson());

    if (response.data == null && response.data['hash_id'] == null) {
      //TODO: testar se avisa o erro
      throw "ID não encontrado na resposta.";
    }

    return response.data['hash_id'];
  }

  Future<void> postOrderStatus(String orderHashId, int statusId) async {
    String nomeFn = 'postOrder() async';
    var response = await _dio.post('pedidos/$orderHashId/statuses',
        data: jsonEncode({'status_id': statusId}));
  }

  Future<List<OrderModel>> getOrders() async {
    String nomeFn = 'postOrder() async';
    var response = await _dio.get('pedidos');

    return (response.data as List)
        .map((orders) => OrderModel.fromJson(orders))
        .toList();
  }

  Future<OrderModel> getOrder(String hashId) async {
    String nomeFn = 'postOrder() async';
    var response = await _dio.get('pedidos/$hashId');

    return OrderModel.fromJson(response.data);
  }
}
