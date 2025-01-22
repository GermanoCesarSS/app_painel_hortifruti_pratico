import 'package:app_painel_hortifruti_pratico/app/core/errors/exception_handlers.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/repository.service.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storageSevice = Get.find<StorageService>();
  final AuthRepository _repository;
  final user = Rxn<UserModel>();
  bool get isLogged => user.value != null;

  AuthService(this._repository);

  @override
  void onInit() async {
    if (_storageSevice.token != null) {
      try {
        await getUser();
      } on UnauthorizedException {
        logout();
      }
    }

    //DESLOGADO
    ever(Get.find<AuthService>().user, (user) {
      if (user == null) {
        Get.offAllNamed(Routes.login);
      }
    });

    super.onInit();
  }

  Future<void> login(UserLoginRequestModel userLoginRequest) async {
    var userLoginResponse = await _repository.login(userLoginRequest);
    await _storageSevice.saveToken(userLoginResponse.token);
    debugPrint('Token de login: ${userLoginResponse.token}');
    await getUser();
  }

  Future<void> getUser() async {
    await _repository.getUser().then(
          (value) => user.value = value,
        );
  }

  Future<void> logout() async {
    await _storageSevice.removeToken();
    user.value = null;
  }
}
