// coverage:ignore-file
import 'package:app_painel_hortifruti_pratico/app/modules/home/controller.dart';
import 'package:app_painel_hortifruti_pratico/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('HomePageScaffold'),
      appBar: AppBar(
        title: const Text('Hortifruti Prático'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.selectCity),
            icon: const Icon(Icons.location_pin),
            tooltip: 'Alterar cidade',
          ),
        ],
      ),
      body: controller.obx(
        (state) => SafeArea(
          child: ListView(
            children: [
              for (var store in state!)
                _buildListItem(
                    id: store.id,
                    titulo: store.name,
                    imagem: store.imagem,
                    isOnline: store.isOnline),
            ],
          ),
        ),
        onEmpty: const Center(
          child: Text(
            'Não tem nenhum estabelecimento disponível para a sua cidade',
            textAlign: TextAlign.center,
          ),
        ),
        onError: (error) => Center(
          child: Text(
            error!,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
      {required int id,
      required String titulo,
      required String imagem,
      required bool isOnline}) {
    return ListTile(
      title: Text(titulo),
      leading: SizedBox(
        width: 56.0,
        child: ClipRRect(
          child: FadeInImage.memoryNetwork(
            imageErrorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 56.00,
              height: 40.00,
              child: FlutterLogo(),
            ),
            placeholder: kTransparentImage,
            image: imagem,
          ),
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: isOnline ? Colors.green : Colors.black45,
          border: Border.all(color: Colors.black12, width: 2.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          isOnline ? 'Aberto' : 'Fechado',
          style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.00, horizontal: 16.00),
      onTap: () => Get.toNamed(Routes.store.replaceFirst(':id', id.toString())),
    );
  }
}
