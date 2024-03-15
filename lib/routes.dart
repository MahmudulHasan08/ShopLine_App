import 'package:flutter/material.dart';
import 'package:shopline_app/common/widgets/bottom_bar.dart';
import 'package:shopline_app/features/address/screens/address_page.dart';
import 'package:shopline_app/features/admin/screens/add_product_page.dart';
import 'package:shopline_app/features/admin/screens/admin_page.dart';
import 'package:shopline_app/features/auth/screens/auth_page.dart';
import 'package:shopline_app/features/home/screens/category_deal_screen.dart';
import 'package:shopline_app/features/home/screens/home_page.dart';
import 'package:shopline_app/features/order/screens/order_details.dart';
import 'package:shopline_app/features/product-details-screen/screeens/product_details_page.dart';
import 'package:shopline_app/features/search/screens/search_page.dart';
import 'package:shopline_app/models/order_model.dart';
import 'package:shopline_app/models/product_model.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );

    case AddProductPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductPage(),
      );

    case AdminScreen.pageRoute:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(searchQuery: searchQuery),
      );

    case ProudctDetailsScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProudctDetailsScreen(product: product),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    
      case OrderDetailsScreen.routeName:
      OrderModel order = routeSettings.arguments as OrderModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
