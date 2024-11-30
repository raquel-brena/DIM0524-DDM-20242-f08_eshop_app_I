
import 'package:f08_eshop_app/pages/carrinho_overview_PAGE.dart';
import 'package:f08_eshop_app/pages/order_overview_page.dart';
import 'package:f08_eshop_app/pages/product_detail_page.dart';
import 'package:f08_eshop_app/pages/product_form_page.dart';
import 'package:f08_eshop_app/pages/products_overview_page.dart';
import 'package:f08_eshop_app/providers/cart_provider.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
        ChangeNotifierProvider(create: (context) => ProductList()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
     //   ChangeNotifierProvider(create: (context) => Orders()),
        // Adicione outros provedores conforme necessário
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            fontFamily: 'Lato',
             textTheme: TextTheme(
            headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              headlineMedium: TextStyle(fontSize: 20, color: Colors.green[700]),
              headlineSmall: TextStyle(fontSize: 16),
            ),
            colorScheme: ThemeData().copyWith().colorScheme.copyWith(
                primary: Colors.pink, secondary: Colors.orangeAccent)),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
          AppRoutes.CART: (context) => CarrinhoOverviewPage(),     
          AppRoutes.ORDERS: (context) => OrdersScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
