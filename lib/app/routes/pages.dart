// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/services.service.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/categpry/binding.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/categpry/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/dashboard/binding.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/dashboard/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/login/binding.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/login/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/binding.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/binding.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/page.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
      middlewares: [RedirectMiddleware()],
    ),
    GetPage(
      name: Routes.catetory,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.product,
      page: () => ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.order,
      page: () => const OrderPage(),
      binding: OrderBinding(),
    ),
  ];
}

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    var storageService = Get.find<StorageService>();

    if (storageService.token != null) {
      return null;
    }
    return const RouteSettings(name: Routes.login);
  }
}
