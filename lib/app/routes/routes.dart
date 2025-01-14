abstract class Routes {
  static const dashboard = '/';
  static const store = '/store/:id';
  static const product = '/product';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const register = '/register';
  static const login = '/login';
  static const userAddress = '/user-address';
  static const userAddressList = '/user-address-list';
  static const order = '/orders/:hashId';
  static const selectCity = '/select-city';
}

abstract class DashboardMenuIndex {
 
  static const int home = 0;
  static const int profile = 1;
  static const int orders = 2;
}
