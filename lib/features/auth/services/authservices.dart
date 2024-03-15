// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shopline_app/common/widgets/bottom_bar.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/features/home/screens/home_page.dart';
import 'package:shopline_app/models/user_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class AuthServices {
//singUp user

  void signUpUser(
      {required BuildContext context,
      required name,
      required email,
      required password}) async {
    try {
      UserModel user = UserModel(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "",
          cart: []
          );
//  http.Response res = await http.post(
//     Uri.parse('$uri/api/signup'),
//   body: user.toJson(),
//   headers: <String,String>{'content-type': 'application/json'}
//   );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // httpErrorHandle(res: res, context: context , onSuccess: (){
      //    showSnackbar(context: context, text: 'Account is successfully created. now login with the same credentials');
      // });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (){},
        onCreateSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
        // onCreateSuccess: () {
        //   showSnackBar(
        //     context,
        //     'Account created! Login with the same credentials!',
        //   );
        // },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required email,
    required password,
  }) async {
    try {
      UserModel user = UserModel(
          id: "",
          name: "",
          email: email,
          password: password,
          address: "",
          type: "",
          token: "",
          cart: []
          );
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: user.toJson(),
        //   body:  jsonEncode({
        //   'email': email,
        //   'password': password,
        // }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(res.body);
      httpErrorHandle(
          response: res,
          context: context,
          onCreateSuccess: (){},
          onSuccess: () async {
            // showSnackBar(context, "login successfully done");
            // Obtain shared preferences.
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            print('shetu');
            //  Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
            //    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //  const HomePage()), (Route<dynamic> route) => false);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          },
  
          );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// get user data --> verified

  void getUserData(BuildContext context) async {

    try{
    //create sharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // get the token but it can be null when user first time create user     
    String? token = prefs.getString('x-auth-token');
    if (token == null) {
       prefs.setString('x-auth-token', '');
    }  
    //now need token valid or not 
    var resToken = await http.post(
      Uri.parse('$uri/tokenIsValid'),
   headers: <String,String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'x-auth-token': token!
   }
    //   headers: <String,String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'x-atuh-token': token!
    // }
    );
     var tokenVerifyData = jsonDecode(resToken.body);
     print(tokenVerifyData);
     if(tokenVerifyData == true){
      // get the data 
      http.Response res = await http.get(Uri.parse('$uri/'),
        headers: <String,String>{
        // 'content-type': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      });
      var userProvider = Provider.of<UserProvider>(context,listen: false);
      userProvider.setUser(res.body);    
     }
      
    }catch(err){
       showSnackBar(context, err.toString());
    }   
  }
}
