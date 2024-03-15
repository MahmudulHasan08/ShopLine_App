import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/account/widgets/single_product.dart';
import 'package:shopline_app/features/home/services/home_services.dart';
import 'package:shopline_app/features/product-details-screen/screeens/product_details_page.dart';
import 'package:shopline_app/models/product_model.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category';
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  HomeServices homeServices = HomeServices();
  List<ProductModel>? products;
  @override
  void initState() {
    getProducts(widget.category);
    super.initState();
  }

  getProducts(String category) async {
    products = await homeServices.fetchProducts(context, category);
    setState(() {});
  }
  void navigateToProductDetails (ProductModel products){
    Navigator.pushNamed(context, ProudctDetailsScreen.routeName, arguments: products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(widget.category),
          centerTitle: true,
        ),
      ),
      body: products == null
          ?const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15.w, top: 10.h),
                  child: Text(
                    'Keep shoping for ${widget.category}',
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                height(10.h),
                Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: SizedBox(
                    height: 170.h,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, childAspectRatio: 1.5),
                        itemBuilder: (_, index) {
                          var product = products![index];
                          return InkWell(
                            onTap: ()=> navigateToProductDetails(product),
                            child: Column(
                              children: [
                                SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                    ),
                                  ),
                                ),
                              ),
                               
                                Text(product.name,maxLines: 1,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
    );
  }
}
