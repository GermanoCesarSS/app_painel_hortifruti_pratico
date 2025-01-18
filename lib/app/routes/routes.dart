abstract class Routes {
  static const dashboard = '/';
  static const product = '/product';
  static const login = '/login';
  static const order = '/orders/:hashId';
  static const catetory = '/catetories/:category_id';
}

abstract class DashboardMenuIndex {
 
  static const int home = 0;
  static const int profile = 1;
  static const int orders = 2;
}
