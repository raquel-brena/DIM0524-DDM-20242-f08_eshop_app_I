import 'package:f08_eshop_app/model/product.dart';

class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final double totalPrice;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.totalPrice,
  });
  
factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: Product.fromJson(json['product']['id'], json['product']),
      quantity: json['quantity'],
      totalPrice: json['totalPrice'].toDouble(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}
