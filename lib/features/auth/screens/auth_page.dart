
import 'package:flutter/material.dart';
import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/common/widgets/custom_textField.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/auth/services/authservices.dart';


enum Auth {
  signin,//0
  signup,//1
}
 final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
class AuthScreen extends StatefulWidget {
  static const String routeName = '/';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 
  final AuthServices authService =  AuthServices();
  Auth _auth = Auth.signup;
  
  final TextEditingController _nameController = TextEditingController();
 final  TextEditingController _emailController = TextEditingController();
 final TextEditingController _passController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void signUpUser(){
    authService.signUpUser(context: context, name: _nameController.text.trim(), email: _emailController.text.trim(), password: _passController.text.trim());
  }

  void signInUser (){
    authService.signInUser(context: context, email: _emailController.text, password: _passController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              leading: Radio(
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
              title: const Text(
                "Create Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //SignUp From field

            if (_auth == Auth.signup)
              Form(
                key: signUpFormKey,
                child: Container(
                  color: GlobalVariables.backgroundColor,
                  padding:const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      GestureDetector(
                        
                        child: CustomTextField(
                            controller: _nameController, hint: "Name"),
                      ),
                      height(10),
                      CustomTextField(
                        controller: _emailController,
                        hint: "Email",
                      ),
                      height(10),
                      CustomTextField(
                        controller: _passController,
                        hint: "Pass",
                      ),
                      height(20),
                      CustomButton(text: "SignUp", onTap: () {
                        if(signUpFormKey.currentState!.validate()){
                          signUpUser();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            // SignIN field
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              leading: Radio(
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
              title: const Text(
                "Sign In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (_auth == Auth.signin)
              Form(
                key: signInFormKey,
                child: Container(
                  color: GlobalVariables.backgroundColor,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hint: "Email",
                      ),
                      height(10),
                      CustomTextField(
                        controller: _passController,
                        hint: "Pass",
                      ),
                      height(20),
                      CustomButton(
                        text: "SIgnIn",
                        onTap: () {
                          signInUser();
                        },
                        color: GlobalVariables.greyBackgroundCOlor,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
