import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/cart.dart';
import 'package:storeapp/favourite.dart';
import 'package:storeapp/model/product_model.dart';
import 'package:storeapp/providers/favourite_provider.dart';
import 'package:storeapp/service/store_service.dart';
import 'package:storeapp/widgets/prudoct_card.dart';
import '../providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storeService = StoreService();
  List<Product> _products = [];
  bool _loading = false;
  String? _error;

  Future<void> _fetchProducts() async {
    setState(() => _loading = true);
    try {
      final products = await _storeService.getAllProducts();
      setState(() {
        _products = products;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = "Error: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final favoritesProvider = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store App"),
        actions: [
          IconButton(
            onPressed: _fetchProducts,
            icon: const Icon(Icons.refresh),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                ),
                icon: const Icon(Icons.favorite),
              ),
              if (favoritesProvider.favorites.isNotEmpty)
                _buildBadge(favoritesProvider.favorites.length),
            ],
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                ),
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              if (cartProvider.cart.isNotEmpty)
                _buildBadge(cartProvider.cart.length),
            ],
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: _products[index]);
              },
            ),
    );
  }

  Widget _buildBadge(int count) {
    return Positioned(
      right: 6,
      top: 6,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
        child: Text(
          count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
