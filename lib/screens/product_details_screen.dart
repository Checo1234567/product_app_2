import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:product_app_login/providers/providers.dart';
import 'package:product_app_login/services/services.dart';
import 'package:product_app_login/theme/theme.dart';
import '../ui_elements/input_decorations.dart';
import '../widgets/widgets.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productServices.selectedProduct),
      child: _ProductDetailScreenBody(productServices: productServices),
    );
  }
}

class _ProductDetailScreenBody extends StatelessWidget {
  const _ProductDetailScreenBody({
    required this.productServices,
  });

  final ProductService productServices;

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productServices.selectedProduct.picture),
                Positioned(
                  top: 30,
                  left: 10,
                  child: IconButton(
                    onPressed: productServices.isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 10,
                  child: IconButton(
                    onPressed: productServices.isSaving
                        ? null
                        : () async {
                            final picker = ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.camera, imageQuality: 10);

                            if (pickedFile == null) {
                              return;
                            } else {
                              // print(
                              //     'Tenemos imagen wiiiiii !!!!!! ${pickedFile.path}');
                              productServices
                                  .updateProductImage(pickedFile.path);
                            }
                          },
                    icon: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 75)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: productServices.isSaving
            ? null
            : () async {
                if (!productFormProvider.isValidForm()) return;

                final String? imageUrl = await productServices.uploadImage();

                if (imageUrl != null) {
                  productFormProvider.productModel.picture = imageUrl;
                }

                await productServices
                    .saveOrCreateProduct(productFormProvider.productModel);
              },
        child: productServices.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    final product = productForm.productModel;

    return Container(
      width: double.infinity,
      height: 280.0,
      decoration: _productFormBoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: productForm.formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The product name is required';
                  }
                  return null;
                },
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Product Name',
                    labelText: 'Name',
                    inputIcon: Icons.video_label,
                    inputColor: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}')),
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '0.0',
                    labelText: 'Price',
                    inputIcon: Icons.attach_money,
                    inputColor: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile(
                value: product.available,
                title: const Text('Available'),
                activeColor: AppTheme.primary,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey[100],
                onChanged: productForm.updateProductAvailability,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _productFormBoxDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}
