import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tedla_client/controller/login_controller.dart';
import 'package:tedla_client/pages/login_page.dart';
import 'package:tedla_client/widgets/otp_txt_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(

        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.amberAccent[300],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              const Text("Create Account!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.amber,
                ),),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.text,
                controller: ctrl.registerNameCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: "Name",
                  hintText: "Enter Your Name",
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNumberCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: "Mobile Number",
                  hintText: "Enter Your Mobile Number",
                ),
              ),
              const SizedBox(height: 20,),
              OtpTextField(otpController: ctrl.otpController, visible: ctrl.otpFieldShow, onComplete: (otp) {
                ctrl.otpEntered = int.tryParse(otp ?? '0000');
              },),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                if(ctrl.otpFieldShow){
                  ctrl.addUser();
                }
                else {
                  ctrl.sendOtp();
                }
              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  child: Text(ctrl.otpFieldShow ? "Register" : "Send OTP"),),
              TextButton(onPressed: () {
                Get.to(const LoginPage());
              },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.brown,
                  ),
                  child: const Text("Login"))

            ],
          ),
        ),
      );
    });
  }
}
