import 'package:f08_eshop_app/model/order_item.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final double totalAmount;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.dateTime,
  });

  factory Order.fromJson(String id, Map<String, dynamic> json) {
    return Order(
      id: id,
      dateTime: DateTime.parse(json['dateTime']),
      totalAmount: json['totalAmount'].toDouble(),
      items: (json['items'] as List<dynamic>).map((item) {
        return OrderItem.fromJson(item);
      }).toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}


