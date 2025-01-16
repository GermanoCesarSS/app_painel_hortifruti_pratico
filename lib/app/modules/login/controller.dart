import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();
  // Perguntar sobre o tipo da variavel
  TextEditingController emailController =
      TextEditingController(text: 'cliente@email.com');
  TextEditingController passwordController =
      TextEditingController(text: '123456');
  final loading = RxBool(false);

  void login() {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) return;

    final UserLoginRequestModel userLoginRequest = UserLoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );

    loading.value = true;

    _authService.login(userLoginRequest).then((value) {
      // if (Get.routing.previous != Routes.checkout) {
      //   Get.offAllNamed(Routes.dashboard,
      //       arguments: DashboardMenuIndex.profile);
      // }

      Get.offNamed(Routes.dashboard);
    }, onError: (error) {
      Get.dialog(AlertDialog(
        title: Text(error.toString()),
      ));
    }).whenComplete(
      () => loading.value = false,
    );
  }
}
