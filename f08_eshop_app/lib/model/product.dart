import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // Constructor that clones from an existing Product
  Product.fromProduct(Product _product)
      : id = _product.id,
        title = _product.title,
        description = _product.description,
        price = _product.price,
        imageUrl = _product.imageUrl,
        isFavorite = _product.isFavorite;

   
  factory Product.fromJson(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(), 
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'] ?? false, 
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
    return data;
  }

 
void toggleFavorite() async {
    final _baseUrl =
        'https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/products';

    isFavorite = !isFavorite;
    notifyListeners();

      final response = await http.patch(
        Uri.parse('$_baseUrl/$id.json'),
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );

      if (response.statusCode >= 400) {
        throw Exception("Falha ao atualizar o favorito!");
      } 
  }
}
