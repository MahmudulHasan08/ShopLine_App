import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/common/widgets/custom_textField.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/features/admin/services/product_service.dart';
import 'package:shopline_app/features/admin/widgets/select_product_img.dart';
import '../../../constants/global_variables.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ProductService productService = ProductService();
  TextEditingController productNameContro = TextEditingController();
  TextEditingController descContro = TextEditingController();
  TextEditingController priceContro = TextEditingController();
  TextEditingController quantityContro = TextEditingController();

  List<String> categories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String category = 'Mobiles';
  List<File> images = [];
  final _addProductKey = GlobalKey<FormState>();
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  addToProduct() {
    if (_addProductKey.currentState!.validate() && images.isNotEmpty) {
      productService.sellProduct(
          context: context,
          name: productNameContro.text,
          description: descContro.text,
          price: double.parse(priceContro.text),
          quantity: double.parse(quantityContro.text),
          category: category,
          images: images);
    }
  }

  @override
  void dispose() {
    productNameContro.dispose();
    descContro.dispose();
    priceContro.dispose();
    quantityContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(images);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 10.w).copyWith(bottom: 20.h),
          child: Form(
            key: _addProductKey,
            child: Column(
              children: [
                height(10.h),
                images.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                            height: 200.h, autoPlay: false, viewportFraction: 1),
                        items: images.map((image) {
                          return Builder(builder: (_) {
                            return Image.file(
                              image,
                              fit: BoxFit.cover,
                              height: 200.h,
                            );
                          });
                        }).toList(),
                      )
                    : selectProductImage(onTap: selectImages),
                height(5.h),
                CustomTextField(
                    controller: productNameContro, hint: 'Product Name'),
                height(10.h),
                CustomTextField(
                  controller: descContro,
                  hint: 'Description',
                  maxLines: 8,
                ),
                height(10.h),
                CustomTextField(controller: priceContro, hint: 'Price'),
                height(10.h),
                CustomTextField(controller: quantityContro, hint: 'Quantity'),
                height(10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton(
                      style: const TextStyle(color: Colors.black87),
                      value: category,
                      items: categories.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      }),
                ),
                height(10.h),
                CustomButton(
                    text: 'Sell',
                    onTap: () {
                      // print("")
                      addToProduct();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
