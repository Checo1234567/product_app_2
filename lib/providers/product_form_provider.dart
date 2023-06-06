import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  ProductModel productModel;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductFormProvider(this.productModel);

  updateProductAvailability(bool value) {
    // print(value);
    productModel.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(productModel.name);
    // print(productModel.price);
    // print(productModel.available);
    return formKey.currentState?.validate() ?? false;
  }
}
