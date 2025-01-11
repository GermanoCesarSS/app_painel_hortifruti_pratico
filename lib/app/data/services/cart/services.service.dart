import 'package:app_painel_hortifruti_pratico/app/data/models/cart_product.module.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.module.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  List<CartProductModel> products = RxList<CartProductModel>.empty();
  final store = Rxn<StoreModel>();
  final observation = RxString('');
  bool get productsIsEmpty => products.isEmpty;

  num get total =>
      products.fold(0, (total, cartProduct) => total + cartProduct.total);

  bool isANexStore(StoreModel newStore) {
    return store.value != null && store.value!.id != newStore.id;
  }

  void clearCart() {
    products.clear();
  }

  void newCart(StoreModel newStore) {
    store.value = newStore;
  }

  void addProductToCart(CartProductModel cartProduct) {
    products.add(cartProduct);
  }

  void removeProductFromCart(CartProductModel cartProduct) {
    products.remove(cartProduct);
  }

  void finalizarCart() {
    clearCart();
    observation.value = '';
  }
}
