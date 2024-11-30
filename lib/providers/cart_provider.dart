import 'dart:convert';
import 'package:f08_eshop_app/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final _baseUrl = 'https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/';

  // Mapa de produtos no carrinho com quantidade
  final Map<Product, int> _cart = {};

  Map<Product, int> get cart =>_cart; 

  int get itemCount => _cart.values.fold(0, (sum, quantity) => sum + quantity);

  double get totalAmount => _cart.entries
      .fold(0, (sum, entry) => sum + entry.key.price * entry.value);

  void addToCart(Product product) {
    if (_cart.containsKey(product)) {
      _cart.update(product, (quantity) => quantity + 1);
    } else {
      _cart[product] = 1;
    }
    print("Adicionado: ${product.title}");
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_cart.containsKey(product)) {
      final currentQuantity = _cart[product]!;
      if (currentQuantity > 1) {
        _cart.update(product, (quantity) => quantity - 1);
      } else {
        _cart.remove(product);
      }
      notifyListeners();
    }
  }

  void increaseQuantity(Product product) {
    if (_cart.containsKey(product)) {
      _cart.update(product, (quantity) => quantity + 1);
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    if (_cart.containsKey(product) && _cart[product]! > 1) {
      _cart.update(product, (quantity) => quantity - 1);
      notifyListeners();
    } else {
      removeFromCart(product);
    }
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
  
  Future<void> finalizeOrder() async {
    final timestamp = DateTime.now();
    final url = '$_baseUrl/orders.json';

    final order = {
      'totalAmount': totalAmount,
      'dateTime': timestamp.toIso8601String(),
      'items': _cart.entries.map((entry) {
        return {
          'productId': entry.key.id,
          'title': entry.key.title,
          'quantity': entry.value,
          'price': entry.key.price,
          'totalPrice': entry.key.price * entry.value,
        };
      }).toList(),
    };

    try {
      final response = await http.post(Uri.parse(url), body: jsonEncode(order));

      if (response.statusCode == 200) {
        clearCart(); // Limpa o carrinho após finalizar o pedido
        notifyListeners();
      } else {
        throw Exception('Erro ao finalizar pedido.');
      }
    } catch (e) {
      throw e;
    }
  }


  // Future<void> addProductWithId(Product product) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$_baseUrl/products.json'),
  //       body: jsonEncode(product.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       final id = jsonDecode(response.body)['name'];
  //       final newProduct = Product(
  //         id: id,
  //         title: product.title,
  //         description: product.description,
  //         price: product.price,
  //         imageUrl: product.imageUrl,
  //       );
  //       _cart[newProduct] = 1;
  //       notifyListeners();
  //     } else {
  //       throw Exception("Erro ao adicionar produto");
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
