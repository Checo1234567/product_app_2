import 'package:flutter/material.dart';
import 'package:product_app_login/models/models.dart';
import 'package:product_app_login/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:product_app_login/services/services.dart';
import 'package:product_app_login/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 135,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        title: const Text('Products'),
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            authService.logOut();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: ListView.builder(
        itemCount: productService.products.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productService.selectedProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productService.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct =
              ProductModel(available: false, name: '', price: 0.0);

          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
