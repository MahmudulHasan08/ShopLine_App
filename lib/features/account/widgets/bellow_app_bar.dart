import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

Widget belowAppBar ({required String userName}){
  return    Container(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              height: 40,
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                     Text.rich(TextSpan(
                      children: [
                     const   TextSpan(text: 'Hello, ',style: TextStyle(
                          fontSize: 22,
                          color: Colors.black
                          // fontWeight: FontWeight.bold,
                        )),
                        TextSpan(text: userName,style:const TextStyle(
                          fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                        ))
                      ]
                    )),
                  ],
                ),
              )
            );
          
}