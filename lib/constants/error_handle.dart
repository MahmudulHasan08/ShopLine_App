// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shopline/constants/utils.dart';

// void httpErrorHandler({
//   required http.Response res,
//   required BuildContext context,
//   required VoidCallback onSuccess
// }){
//   switch (res.statusCode) {
//     case 200:
//     onSuccess();
//      case 400:
//       showSnackbar(context: context, text: jsonDecode(res.body)['message'] );
//       break;
//       case 500: 
//       showSnackbar(context: context, text: jsonDecode(res.body)['message']);
//       break;

//     default:
//     showSnackbar(context: context, text: jsonDecode(res.body));
//   }
// }
//------------------->
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopline_app/constants/utils.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required VoidCallback onCreateSuccess,
}) {
  switch (response.statusCode) {
    
    case 200:
      onSuccess();
      break;
      case 201:
      onCreateSuccess();
    case 400:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
      case 401:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
      case 404:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}


//___________>>>>

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shopline_app/constants/utils.dart';

// void httpErrorHandle({
//   required http.Response response,
//   required BuildContext context,
//   required VoidCallback onSuccess,
// }) {
//   switch (response.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//       showSnackBar(context, jsonDecode(response.body)['msg']);
//       break;
//     case 500:
//       showSnackBar(context, jsonDecode(response.body)['error']);
//       break;
//     default:
//       showSnackBar(context, response.body);
//   }
// }