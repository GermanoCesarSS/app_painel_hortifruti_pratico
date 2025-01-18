import 'package:app_painel_hortifruti_pratico/app/data/models/next_status.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_status.module.dart';
import 'package:flutter/material.dart';

typedef OnChangeStatus = void Function(int statusId);

class OrderNextStatusWidget extends StatelessWidget {
  final OnChangeStatus onChangeStatus;
  final OrderStatusModel currentStatus;
  OrderNextStatusWidget({required this.currentStatus, required this.onChangeStatus, super.key,});

  final nextStatusList = {
    1: [
      NextStatus(2, 'Confirmar'),
      NextStatus(5, 'Recusar', isOk: false),
    ],
    2: [
      NextStatus(3, 'Saiu para entrega'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
    3: [
      NextStatus(4, 'Entregue'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
  };

  @override
  Widget build(BuildContext context) {
    var options = nextStatusList[currentStatus.id];

    if (options == null) {
      return const SizedBox();
    }

    return Row(
      spacing: 8.0,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var nextStatus in options) ...[
          OutlinedButton(
            onPressed: () => onChangeStatus(nextStatus.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: nextStatus.isOk ? Colors.green : Colors.red,
              side: BorderSide(
                  color: nextStatus.isOk ? Colors.green : Colors.red),
            ),
            child: Text(nextStatus.text),
          ),
        ]
      ],
    );
  }
}
