import 'package:app_painel_hortifruti_pratico/app/modules/login/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Informe o seu email';
                  } else if (!value!.isEmail) {
                    return 'Informe um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: controller.login,
                        child: const Text('Entrar'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed(Routes.register),
                      child: const Text('Criar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextoFormulario extends StatelessWidget {
  final TextEditingController compoControle;
  final String? titulo;
  final String? Function(String?)? fn;

  const TextoFormulario({
    super.key,
    required this.compoControle,
    required this.titulo,
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: compoControle,
      decoration: InputDecoration(
        labelText: '$titulo',
      ),
      validator: fn ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Informe $titulo';
            }
            return null;
          },
    );
  }
}
