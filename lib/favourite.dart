import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/providers/favourite_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favoritesProvider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favoritesProvider.favorites.length,
              itemBuilder: (_, index) {
                final product = favoritesProvider.favorites[index];
                return ListTile(
                  leading: Image.network(product.image, width: 40),
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => favoritesProvider.toggleFavorite(product),
                  ),
                );
              },
            ),
    );
  }
}
