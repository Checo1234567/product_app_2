import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _productImageBoxDecoration(),
      width: double.infinity,
      height: 450,
      child: Opacity(
        opacity: 0.8,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: getImage(url)),
      ),
    );
  }

  BoxDecoration _productImageBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ]);
  }

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
          image: AssetImage('assets/images/no-image.png'), fit: BoxFit.cover);
    }

    if (picture.startsWith('http')) {
      return FadeInImage(
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover);
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
