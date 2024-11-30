import 'dart:convert';
import 'package:f08_eshop_app/model/order_item.dart';
import 'package:http/http.dart' as http;
import '../model/order.dart';
import '../model/product.dart';

class OrderService {
  final String _baseUrl =
      "https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/orders.json";

  Future<void> addOrder(Map<Product, int> cartItems, double totalAmount) async {
    Order orderData = Order(
      id: "", 
      dateTime: DateTime.now(),
      totalAmount: totalAmount,
      items: cartItems.entries.map((entry) {
        return OrderItem(
          id: entry.key.id,
          product: entry.key,
          quantity: entry.value,
          totalPrice: entry.key.price * entry.value,
        );
      }).toList(),
    );

    final response = await http.post(
      Uri.parse(_baseUrl),
      body: jsonEncode(orderData),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao criar pedido");
    }
  }

  Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(_baseUrl));
    final List<Order> loadedOrders = [];

    if (response.statusCode == 200) {
      final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
      
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(Order.fromJson(orderId, orderData));
      });
    } else {
      throw Exception("Erro ao buscar pedidos");
    }

    return loadedOrders;
  }
}
