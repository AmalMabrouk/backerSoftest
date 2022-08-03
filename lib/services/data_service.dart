import 'dart:convert';

import 'package:bakersofttest/models/product.dart';
import 'package:flutter/services.dart';

class DataService {
  List<Product> list = List.empty(growable: true);

  Future<List<Product>> getProducts() async {
   final String response = await rootBundle.loadString('assets/products.json');
   final data = await json.decode(response);
  return List<Product>.from(data["items"].map((model) => Product.fromJson(model)));
  }
}
