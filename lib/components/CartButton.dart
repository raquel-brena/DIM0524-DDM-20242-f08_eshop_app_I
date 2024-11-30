import 'package:f08_eshop_app/providers/cart_provider.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.provider,
  });

  final CartProvider provider;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          AppRoutes.CART,
        );
      },
      backgroundColor: Colors.pink.shade800, 
      child: Stack(
        clipBehavior: Clip.none, 
        children: [
          const Icon(
            Icons.shopping_cart,
            size: 30, // Tamanho do ícone
            color: Colors.white,
          ),
          if (provider.itemCount > 0) 
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  provider.itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
