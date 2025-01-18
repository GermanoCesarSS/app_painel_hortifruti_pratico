// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/modules/category_list/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/page.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/user_profile/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetResponsiveView<DashboardController> {
  DashboardPage({super.key});

  @override
  Widget desktop() {
    return Scaffold(
      body: Obx(
        () => Row(
          children: [
            NavigationRail(
              elevation: 24,
              onDestinationSelected: controller.changePageIndex,
              selectedIndex: controller.currentPageIndex.value,
              labelType: NavigationRailLabelType.all,
              leading: FlutterLogo(
                size: 48.0,
                style: FlutterLogoStyle.stacked,
              ),
              // labelType: labelType,
              // leading: showLeading
              //     ? FloatingActionButton(
              //         elevation: 0,
              //         onPressed: () {
              //           // Add your onPressed code here!
              //         },
              //         child: const Icon(Icons.add),
              //       )
              //     : const SizedBox(),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  label: Text('Inicio'),
                  selectedIcon: Icon(Icons.explore),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_outline),
                  label: Text('Produtos'),
                  selectedIcon: Icon(Icons.person),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.view_list_outlined),
                  label: Text('Configurar'),
                  selectedIcon: Icon(Icons.view_list),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
        key: const Key('DashboardPageScaffold'),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: controller.changePageIndex,
            selectedIndex: controller.currentPageIndex.value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Inicio',
                selectedIcon: Icon(Icons.explore),
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Produtos',
                selectedIcon: Icon(Icons.person),
              ),
              NavigationDestination(
                icon: Icon(Icons.view_list_outlined),
                label: 'Configurar',
                selectedIcon: Icon(Icons.view_list),
              ),
            ],
          ),
        ),
        body: Obx(() => _body()));
  }

  IndexedStack _body() {
    return IndexedStack(
      index: controller.currentPageIndex.value,
      children: [
        OrderListPage(),
        CategoryListPage(),
        const UserProfilePage(),
      ],
    );
  }
}
