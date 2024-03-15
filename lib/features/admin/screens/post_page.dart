import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/features/account/widgets/single_product.dart';
import 'package:shopline_app/features/admin/screens/add_product_page.dart';
import 'package:shopline_app/features/admin/services/product_service.dart';
import 'package:shopline_app/models/product_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
   getProducts();
    super.initState();
  }
  ProductService productService = ProductService();
  List<ProductModel> productData = [];
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductPage.routeName);
  }
  void deleteProduct (String id) async {
   await productService.deleteProduct(context, id);
   setState(() {});
   
  }

  void getProducts() async {
    productData = await productService.fetchAllProducts(context);;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 65.w,
        width: 65.w,
        child: FloatingActionButton(
          backgroundColor: Colors.cyan[800],
          onPressed: navigateToAddProduct,
          tooltip: 'Add a post',
          splashColor: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: productData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: productData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, index) {
                var product = productData[index];
                print('image url is :${jsonEncode(product.images[0])}');
                return SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140.h,
                        child: singleProduct(imageUrl:product.images[0]),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 15.w),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              product.name,
                              style:const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500
                              
                              ),
                              maxLines: 2,
                            ),),
                             IconButton(
                            onPressed: () {
                              print('shetu');
                              print(product.name);
                              deleteProduct(product.id!);
                            },
                            icon:  Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade200,
                            ),
                          ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
