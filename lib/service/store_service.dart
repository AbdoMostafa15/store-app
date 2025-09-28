import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:storeapp/model/product_model.dart';

class StoreService {
  final String apiUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
