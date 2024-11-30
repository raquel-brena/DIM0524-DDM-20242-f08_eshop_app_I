import 'package:f08_eshop_app/components/product_cart_grid.dart';
import 'package:flutter/material.dart';

import '../utils/app_routes.dart';


class CartOverviewPage extends StatefulWidget {
  CartOverviewPage({Key? key}) : super(key: key);

  @override
  State<CartOverviewPage> createState() => _CartOverviewPageState();
}

class _CartOverviewPageState extends State<CartOverviewPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Meu carrinho'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: ProductCartGrid(),
    );
  }
}
