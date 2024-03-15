import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/common/widgets/custom_textField.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/features/address/services/address_services.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/payment_configurations.dart';
import 'package:shopline_app/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressServices addressServices = AddressServices();
  // List<PaymentItem> paymentItems = [];
  final _addressFromKey = GlobalKey<FormState>();
  final TextEditingController flatBuildingContro = TextEditingController();
  final TextEditingController areaContro = TextEditingController();
  final TextEditingController pinCodeContro = TextEditingController();
  final TextEditingController cityContro = TextEditingController();
  String addressToBeUsed = '';

  String addressPress(String addressFromServer) {
    addressToBeUsed = '';
    bool isForm = flatBuildingContro.text.isNotEmpty ||
        areaContro.text.isNotEmpty ||
        pinCodeContro.text.isNotEmpty ||
        cityContro.text.isNotEmpty;
    if (isForm) {
      if (_addressFromKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingContro.text}, ${areaContro.text}, ${pinCodeContro.text} - ${cityContro.text}';
        flatBuildingContro.clear();
        areaContro.clear();
        pinCodeContro.clear();
        cityContro.clear();
      } else {
        throw Exception('Please Enter all the field');
      }
    } else if (addressFromServer.isNotEmpty) {
      addressToBeUsed = addressFromServer;
    } else {
      showSnackBar(context, "Error");
    }
    return addressToBeUsed;
  }

  @override
  void dispose() {
    flatBuildingContro.dispose();
    areaContro.dispose();
    pinCodeContro.dispose();
    cityContro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address =
        Provider.of<UserProvider>(context, listen: false).user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    margin: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black12,
                      width: 1.5.w,
                    )),
                    child: Text(
                      address,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  height(15.h),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                    ),
                  ),
                  height(15.h),
                ],
              ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Form(
                key: _addressFromKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: flatBuildingContro,
                        hint: "Flat, House no. Building"),
                    height(8.h),
                    CustomTextField(
                        controller: areaContro, hint: "Area, Street"),
                    height(8.h),
                    CustomTextField(controller: pinCodeContro, hint: "Pincode"),
                    height(8.h),
                    CustomTextField(controller: cityContro, hint: "Town/City"),
                    height(15.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: CustomButton(
                text: "Add Address",
                onTap: () {
                  if (_addressFromKey.currentState!.validate()) {
                    String address = addressPress(
                        Provider.of<UserProvider>(context, listen: false)
                            .user
                            .address);
                    addressServices.saveUserAddress(context, address);
                  }
                  // addressServices.placeOrder(
                  //     context: context,
                  //     address: address1,
                  //     totalAmount: double.parse(widget.totalAmount));
                },
              ),
            ),
            height(15.h),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: CustomButton(
                text: "Add order",
                onTap: () {
                 
                  addressServices.placeOrder1(
                    context: context,
                    address: Provider.of<UserProvider>(context,listen: false).user.address,
                    totalSum: double.parse(widget.totalAmount),
                  );
                  print('add order');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
