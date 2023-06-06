import 'package:flutter/material.dart';
import 'package:product_app_login/models/models.dart';
import 'package:product_app_login/theme/theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _productCardDecoration(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundCardImage(url: product.picture),
            _ProductDetails(id: product.id, name: product.name),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(price: product.price),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: _ProductStatus(
                productStatus: product.available,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _productCardDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 8),
            blurRadius: 10,
          ),
        ]);
  }
}

class _ProductStatus extends StatelessWidget {
  final bool productStatus;

  const _ProductStatus({required this.productStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: _productStatusBoxDecoration(),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(productStatus ? 'Available' : 'No stock'),
          // child: Text('No stock'),
        ),
      ),
    );
  }

  BoxDecoration _productStatusBoxDecoration() {
    return BoxDecoration(
      color: productStatus ? Colors.amber : Colors.red,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    );
  }
}

class _BackgroundCardImage extends StatelessWidget {
  final String? url;

  const _BackgroundCardImage({this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: url == null
            ? const Image(
                image: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String? id;
  final String name;

  const _ProductDetails({this.id, required this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _productDetailBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              id!,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _productDetailBoxDecoration() {
    return const BoxDecoration(
      color: AppTheme.primary,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: _priceTagBoxDecoration(),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            '\$$price',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _priceTagBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
      color: AppTheme.primary,
    );
  }
}
