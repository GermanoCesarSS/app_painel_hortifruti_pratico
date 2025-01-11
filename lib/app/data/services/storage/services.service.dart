import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final _box = GetStorage();
  final _token = RxnString();
  final _cityId = RxnInt();

  String? get token => _token.value;
  int? get cityId => _cityId.value;

  @override
  void onInit() {
    //TOKEN
    _token.value = _box.read(StorageKey.token.toString());

    _box.listenKey(
      StorageKey.token.toString(),
      (value) => _token.value = value,
    );

    //CITY
    _cityId.value = _box.read(StorageKey.cityId.toString());

    _box.listenKey(
      StorageKey.cityId.toString(),
      (value) => _cityId.value = value,
    );

    super.onInit();
  }

  Future<void> saveToken(String token) async {
    await _box.write(StorageKey.token.toString(), token);
  }

  Future<void> removeToken() async {
    await _box.remove(StorageKey.token.toString());
  }

  Future<void> saveCity(int cityId) async {
    await _box.write(StorageKey.cityId.toString(), cityId);
  }
}

enum StorageKey {
  token,
  cityId,
}
