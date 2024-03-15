import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.maxLines=1,
  }) : super(key: key);

 final TextEditingController controller;
 final String hint;
 final int maxLines;
  @override
  Widget build(BuildContext context) {
    return      TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  decoration:  InputDecoration(
                    hintText: hint,   
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                      ) 
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                      )
                    )
                  ),
                  validator: (val){
                     if(val! == null || val.isEmpty){
                       return "Enter your $hint";
                     }
                  },
                 
                 )
             ;
  }
}
