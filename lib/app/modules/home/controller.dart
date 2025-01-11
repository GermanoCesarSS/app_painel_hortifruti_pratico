import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/home/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  var counter = RxInt(0);
  final HomeRepository _repository;

  HomeController(this._repository);

  HomeRepository get repository => _repository;

  @override
  void onInit() {
    // int cityId = Get.find<StorageService>().cityId!;
    int cityId = 1;

    _repository.getStores(cityId).then((data) {
      if (data.isNotEmpty) {
        change(data, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }

  void incrementCounter() {
    counter.value++;
    debugPrint('incrementCounter');
    debugPrint('Valor do HomeController.counter.value: ${counter.value}');
  }
}
