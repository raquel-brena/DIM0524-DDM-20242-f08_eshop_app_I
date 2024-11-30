import 'package:f08_eshop_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:f08_eshop_app/model/product.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';

class ProductCartItem extends StatelessWidget {
  final Product product;
  final int quantity;

  const ProductCartItem({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double total = product.price * quantity;

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Text(
              'Preço por unidade: R\$ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Quantidade: $quantity',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    cartProvider.removeFromCart(product);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  color: Colors.redAccent,
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    cartProvider.addToCart(product);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
