import 'package:app_painel_hortifruti_pratico/app/modules/product/widgts/quantity_and_weight/quantity_and_weight_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeightWidget extends StatelessWidget {
  var controller = Get.find<QuantityAndWeightController>();

  WeightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${NumberFormat.decimalPattern().format(controller.min)}Kg',
          style: Get.textTheme.titleSmall,
        ),
        Expanded(
          child: GestureDetector(
            onTapDown: (details) => controller.enableSlider(),
            child: Slider(
                min: controller.min,
                max: controller.max,
                divisions: 5,
                label: controller.label,
                value: controller.weigth,
                onChanged: (value) {
                  if (controller.sliderEnabled.isTrue) {
                    controller.changeWeigth(value);
                  }
                }),
          ),
        ),
        Text(
          '${NumberFormat.decimalPattern().format(controller.max)}Kg',
          style: Get.textTheme.titleSmall,
        ),
      ],
    );
  }
}
