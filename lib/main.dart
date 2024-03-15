import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/bottom_bar.dart';
import 'package:shopline_app/features/admin/screens/admin_page.dart';
import 'package:shopline_app/features/auth/screens/auth_page.dart';
import 'package:shopline_app/features/auth/services/authservices.dart';
import 'package:shopline_app/features/home/screens/home_page.dart';
import 'package:shopline_app/providers/user_provider.dart';
import 'package:shopline_app/routes.dart';
import 'constants/global_variables.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthServices authService = AuthServices();
  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const  Size(411, 843),
      builder: (_,child){
        return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHOPLINE',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ?Provider.of<UserProvider>(context).user.type == 'user' ? const BottomBar() : const AdminScreen()
          : const AuthScreen(),
    );
 
      },
    ); }
}
