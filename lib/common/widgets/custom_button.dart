// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//  final String name;
//  final VoidCallback onPressed;
//  final Color? color;

//   const CustomButton({
//     Key? key,
//     required this.name,
//     required this.onPressed,
//      this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return  ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//       minimumSize:const Size(double.infinity, 50),
//       backgroundColor: color,
//     ),
//       child:  Text(name,style: TextStyle(
//         color: color==null? Colors.white:Colors.black,
//       ),),);
//   }
// }
import 'package:flutter/material.dart';
import 'package:shopline_app/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
      ),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        // primary: color,
        // side: BorderSide(),
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color ?? GlobalVariables.secondaryColor,
        
      ),
    );
  }
}
