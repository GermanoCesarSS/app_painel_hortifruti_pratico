import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class QuantityAndWeightController extends GetxController {
  final bool isKg;
  QuantityAndWeightController({required this.isKg});

  num quantity = 1;
  double get weigth => quantity.toDouble();
  late double min;
  late double max;
  final sliderEnabled = RxBool(false);

  String get label {
    String unit = 'Kg';
    String pattern = '0.00';
    var number = weigth;
    if (number < 1) {
      number += 1000;
      unit = 'g';
      pattern = '';
    } else if (number % number.toInt() == 0) {
      pattern = '';
    }
    return NumberFormat(pattern).format(number) + unit;
  }

  @override
  void onInit() {
    _updateMinAndMax();
    super.onInit();
  }

  void changeQuantity(num value) {
    quantity = value;
    _updateMinAndMax();
    update();
  }

  void changeWeigth(value) {
    quantity = value;

    update();
  }

  _updateMinAndMax() {
    min = weigth - 1 + 0.5;
    max = weigth;

    if (min < 0) {
      min = 0.05;
      max = 1;
    }
  }

  void enableSlider() => sliderEnabled.value = true;
}