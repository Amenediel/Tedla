import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:tedla_client/pages/home_page.dart';

import '../models/users/user.dart';

class LoginController extends GetxController {
  final box =GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();

  TextEditingController loginNumberCtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShow = false;
  int? otpSent;
  int? otpEntered;

  User? loginUser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginUser');
    if(user != null) {
      loginUser = User.fromJson(user);
      Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser(){
    try {
      if(otpSent == otpEntered){
        DocumentReference doc = userCollection.doc();

        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),

        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar(
            'Success', 'User successfully added', colorText: Colors.green);
        registerNumberCtrl.clear();
        registerNameCtrl.clear();
        otpController.clear();
    }else{
        Get.snackbar(
            'Error', 'Incorrect OTP', colorText: Colors.red);

      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),colorText: Colors.red);
      print(e);
    }
  }

  sendOtp(){
    try {

      if(registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty)
      {
        Get.snackbar('Error', 'Please Fill in the fields properly',colorText: Colors.red[900]);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);
            otpFieldShow = true;
            otpSent = otp;
            Get.snackbar('Success', 'OTP successfully sent!', colorText: Colors.green);
              } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;
      if(phoneNumber.isNotEmpty)
            {
              var querySnapshot = await userCollection.where('number', isEqualTo: int.tryParse(phoneNumber)).limit(1).get();
              if(querySnapshot.docs.isNotEmpty){
                var userDoc = querySnapshot.docs.first;
                var userData = userDoc.data() as Map<String, dynamic>;
                box.write('loginUser', userData);
                loginNumberCtrl.clear();
                Get.to(const HomePage());
                Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
              } else{
                Get.snackbar('Error', 'User not Found, please register', colorText: Colors.red);
              }
            }
          else{
            Get.snackbar('Error', 'Please Enter a Phone number', colorText: Colors.red);
          }
    } catch (error) {
      print("Failed to login: $error");
      Get.snackbar('Error', 'Failed to login', colorText: Colors.red);
    }
  }
}