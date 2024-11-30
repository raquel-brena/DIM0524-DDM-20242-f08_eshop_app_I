import 'package:f08_eshop_app/components/product_cart_item.dart';
import 'package:f08_eshop_app/providers/cart_provider.dart';
import 'package:f08_eshop_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';
import '../utils/app_routes.dart';

class ProductCartGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    late Map<Product, int> _products = provider.cart;

    if (_products.isEmpty) {
      return const Center(
        child: Text("Carrinho vazio"),
      );
    } else {
      return ProductCartGridView(products: _products);
    }
  }
}

class ProductCartGridView extends StatelessWidget {
  const ProductCartGridView({
    super.key,
    required this.products,
  });

  final Map<Product, int> products;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final orderService = OrderService(); 

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: products.length,
            itemBuilder: (ctx, i) {
              final product = products.keys.elementAt(i);
              final quantity = products.values.elementAt(i);
              return ProductCartItem(product: product, quantity: quantity);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total do Carrinho:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'R\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (products.isNotEmpty) {
           
                    orderService.addOrder(
                        cartProvider.cart, cartProvider.totalAmount);

                    cartProvider.clearCart();

                    Navigator.of(context).pushNamed(AppRoutes.ORDERS);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Finalizar Compra',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
