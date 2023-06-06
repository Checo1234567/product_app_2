import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:product_app_login/models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseURL = 'flutter-varios-2af25-default-rtdb.firebaseio.com';
  final List<ProductModel> products = [];

  late ProductModel selectedProduct;

  bool isLoading = true;
  bool isSaving = true;

  File? newPictureFile;

  //TODO: Hacer fetch de productos

  ProductService() {
    loadProducts();
  }

  Future<List<ProductModel>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseURL, 'products.json');
    final res = await http.get(url);

    final Map<String, dynamic> productMap = json.decode(res.body);

    productMap.forEach((key, value) {
      final tempProduct = ProductModel.fromMap(value);
      tempProduct.id = key;

      products.add(tempProduct);
    });

    // print(productMap);

    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProduct(ProductModel product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //Create
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductModel product) async {
    final url = Uri.https(_baseURL, 'products/${product.id}.json');
    await http.put(url, body: product.toJson());
    // final res = await http.put(url, body: product.toJson());

    // final decodedData = res.body;

    // print(decodedData);

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(ProductModel product) async {
    final url = Uri.https(_baseURL, 'products.json');
    final res = await http.post(url, body: product.toJson());

    final decodedData = json.decode(res.body);
    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }

  void updateProductImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/drjcjzf5j/image/upload?upload_preset=jre5cpls');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final res = await http.Response.fromStream(streamResponse);

    if (res.statusCode != 200 && res.statusCode != 201) {
      print(res.body);
      print('Something went wrong!');
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(res.body);

    return decodedData['secure_url'];
  }
}
