class ApiPath {
  static String products() => 'products/';
  static String product(String id) => 'products/$id';

  static String deliveryMethods() => 'deliveryMethods/';
  static String user(String uid) => 'users/$uid';
  static String userShippingAddress(String uid) => 'users/$uid/shippingAddresses/';
  static String newAddress(String uid, String addressId) => 'users/$uid/shippingAddresses/$addressId';
  static String addToCart(String uid, String addToCartId) => 'users/$uid/cart/$addToCartId';
  static String myProductsCart(String uid) => 'users/$uid/cart/';

  static String addCard(String uid, String cardId) => 'users/$uid/cards/$cardId';
  static String cards(String uid) => 'users/$uid/cards/';
}
