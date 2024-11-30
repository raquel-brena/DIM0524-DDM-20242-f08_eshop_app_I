import 'package:f08_eshop_app/model/product_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product>();

    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
        
          
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Consumer<Product>(
                builder: (context, product, child) => Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border),
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () => Provider.of<ProductList>(context, listen: false).removeProduct(product),
                icon: Icon(Icons.delete),
                color: Theme.of(context).colorScheme.secondary),
          ),
        
        ),
      ),
          onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
      },
    );
  }
}
