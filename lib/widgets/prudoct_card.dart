import 'package:flutter/material.dart';
import 'package:storeapp/model/product_model.dart';
import 'package:storeapp/providers/cart_provider.dart';
import 'package:storeapp/providers/favourite_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final favoritesProvider = context.watch<FavoritesProvider>();

    final isInCart = cartProvider.isInCart(product);
    final isFavorite = favoritesProvider.isFavorite(product);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.network(product.image, fit: BoxFit.contain)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("\$${product.price.toStringAsFixed(2)}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () => favoritesProvider.toggleFavorite(product),
              ),
              IconButton(
                icon: Icon(
                  isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                  color: isInCart ? Colors.green : Colors.grey,
                ),
                onPressed: () => isInCart
                    ? cartProvider.removeFromCart(product)
                    : cartProvider.addToCart(product),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
