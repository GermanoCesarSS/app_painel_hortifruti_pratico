import 'package:app_painel_hortifruti_pratico/app/data/models/user_profile_request.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/auth/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/user_profile/repository.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  final UserProfileRepository _repository;
  final _authService = Get.find<AuthService>();

  UserProfileController(this._repository);

  final formKey = GlobalKey<FormState>();
  // Perguntar sobre o tipo da variavel
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  bool isPhone = false;
  var passwordController = TextEditingController();
  final loading = RxBool(false);
  bool get isLogged => _authService.isLogged;

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchUser());
    // fetchUser();

    super.onInit();
  }

  void fetchUser() {
    _repository.getUser().then(
      (data) {
        loading.value = true;
        nameController.text = data.name;
        emailController.text = data.email;
        if (data.phone != null) {
          phoneController.text = data.phone!;
          isPhone = true;
        }
        loading.value = false;
      },
      onError: (error) {
        loading.value = false;
      },
    );
  }

  void submit() {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) return;

    var userProfileRequest = UserProfileRequestModel(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    _repository.putUser(userProfileRequest).then((value) {
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        const SnackBar(content: Text('Seu perfil foi atualizado')),
      );
      passwordController.text = '';
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      );
    });
  }

  void logout() async {
    await _authService.logout();
    Get.offAllNamed(Routes.dashboard);
  }
}
