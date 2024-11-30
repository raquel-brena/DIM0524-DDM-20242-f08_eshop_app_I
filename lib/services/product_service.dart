import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:f08_eshop_app/model/product.dart';

class ProdutoService {
  final String _baseUrl =
      "https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/";

  Future<List<Product>> fetchProdutos() async {
    
    List<Product> products = [];
    try {
      final response = await http.get(Uri.parse("$_baseUrl/products.json"));

      if (response.statusCode == 200) {
        final _productsJson = jsonDecode(response.body) as Map<String, dynamic>;

        _productsJson.forEach((id, product) {
          if (product != null) {
            products.add(Product.fromJson(id, product));
          }
        });
    
        return products;
      } else {
        throw Exception("Erro ao carregar produtos: ${response.statusCode}");
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    List<Product> items = [];
    try {
      var response = await http.post(Uri.parse("$_baseUrl/products.json"), body: jsonEncode(product.toJson()));

      if (response.statusCode == 200) {
        final id = jsonDecode(response.body)["name"];
        items.add(Product(
            id: id,
            title: product.title,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl));
      } else {
        throw Exception("Aconteceu algum erro na requisição");
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduto(Product product) async {
    final url = Uri.parse(
        'https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/products/${product.id}.json');

    try {
      final response = await http.put(
        url,
        body: jsonEncode(product.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception("Erro ao atualizar produto: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProduto(String id) async {
    final url = Uri.parse(
        "https://miniprojeto04-fd83d-default-rtdb.firebaseio.com/products/$id.json");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
      } else {
        throw Exception("Erro ao deletar produto: ${response.statusCode}");
      }
    } catch (e) {
    }
  }
}
