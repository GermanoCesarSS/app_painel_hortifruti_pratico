import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/quantity_and_weight/quantity_and_weight_controller.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/quantity_and_weight/quantity_widget.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/quantity_and_weight/weigth_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityAndWeightWidget extends StatelessWidget {
  final bool isKg;
  const QuantityAndWeightWidget({super.key, required this.isKg});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuantityAndWeightController>(
      init: QuantityAndWeightController(isKg: isKg),
      builder: (controller) => Column(
        children: [
          QuantityWidget(),
          if (isKg) WeightWidget(),
        ],
      ),
    );
  }
}
