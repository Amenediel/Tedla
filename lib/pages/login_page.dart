import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tedla_client/controller/login_controller.dart';
import 'package:tedla_client/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(

        backgroundColor: Colors.brown[50],
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.amberAccent[300],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              const Text("Welcome Back!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.amber,
                ),),
              const SizedBox(height: 20,),
              TextField(
                controller: ctrl.loginNumberCtrl,
                keyboardType: TextInputType.phone,
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
              ElevatedButton(onPressed: () {
                ctrl.loginWithPhone();
              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text("Login")),
              TextButton(onPressed: () {
                Get.to(RegisterPage());
              },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.brown,
                  ),
                  child: const Text("Register new account?"))

            ],
          ),
        ),
      );
    });
  }
}
