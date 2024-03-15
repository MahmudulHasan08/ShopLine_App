import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/loader.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/home/widgets/address_box.dart';
import 'package:shopline_app/features/search/services/search_services.dart';
import 'package:shopline_app/features/search/widgets/search_product.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchServices searchServices = SearchServices();
  List<ProductModel>? products;
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    getSearchData(widget.searchQuery);
    super.initState();
  }

  void getSearchData(String nameQuery) async {
    products = await searchServices.fetchSerachData(context, nameQuery);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15.w,
                  ),
                  height: 42.h,
                  child: Material(
                    borderRadius: BorderRadius.circular(7.r),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23.w,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10.h),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1.h)),
                        hintText: 'ShopLine.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(Icons.mic, color: Colors.black, size: 25.w),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(children: [
              addressBox(
                text: 'Delivery to ${user.name} - Admin - ${user.address}',
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: products!.length, 
                    itemBuilder: (_, index) {
                      var product = products![index];
                      return Padding(
                        padding:  EdgeInsets.symmetric(vertical: 10.h),
                        child: SearchedProduct(product: product),
                      );
                    }),
              ),
            ]),
    );
  }
}
