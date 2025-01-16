import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final _box = GetStorage();
  final _token = RxnString();

  String? get token => _token.value;

  @override
  void onInit() {
    //TOKEN
    _token.value = _box.read(StorageKey.token.toString());

    _box.listenKey(
      StorageKey.token.toString(),
      (value) => _token.value = value,
    );

    super.onInit();
  }

  Future<void> saveToken(String token) async {
    await _box.write(StorageKey.token.toString(), token);
  }

  Future<void> removeToken() async {
    await _box.remove(StorageKey.token.toString());
  }
  
}

enum StorageKey {
  token,
  cityId,
}
