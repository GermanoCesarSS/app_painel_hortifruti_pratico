import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InformacaoLinha extends StatelessWidget {
  final String titulo;
  final String numero;
  final TextStyle? estiloTitulo;
  final TextStyle? estiloNumero;

  const InformacaoLinha({
    super.key,
    required this.titulo,
    required this.numero,
    this.estiloTitulo,
    this.estiloNumero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$titulo: ',
              style: estiloTitulo ?? Get.textTheme.titleMedium,
            ),
          ),
          Text(
            numero,
            style: estiloNumero ?? Get.textTheme.titleMedium,
            
          ),
        ],
      ),
    );
  }
}
