import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartProvider.cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cartProvider.cart.length,
              itemBuilder: (_, index) {
                final product = cartProvider.cart[index];
                return ListTile(
                  leading: Image.network(product.image, width: 40),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => cartProvider.removeFromCart(product),
                  ),
                );
              },
            ),
    );
  }
}
