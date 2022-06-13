import 'package:flutter_ecommerce/utilities/constants/image_manager.dart';

class Product {
  final String id;
  final String title;
  final int price;
  final String imgUrl;
  final int? discountValue;
  final String category;
  final double? rate;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    this.discountValue,
    this.category = 'Other',
    this.rate,
  });
}

List<Product> dummyProducts = [
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset2,
    category: 'Clothes',
    discountValue: 20,
    rate: 3,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
    rate: 3,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset2,
    category: 'Clothes',
    discountValue: 20,
    rate: 4,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
    rate: 5,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset2,
    category: 'Clothes',
    rate: 3,
  ),
  Product(
    id: '1',
    title: 'T-shirt',
    price: 300,
    imgUrl: ImageManager.tempProductAsset1,
    category: 'Clothes',
    discountValue: 20,
    rate: 3,
  ),
];
