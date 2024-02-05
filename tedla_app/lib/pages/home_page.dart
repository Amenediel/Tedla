import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tedla_app/controller/home_controller.dart';
import 'package:tedla_app/pages/add_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: const Text("Tedla Admin"),
          centerTitle: true,
          backgroundColor: Colors.amber,),
        body: ListView.builder(
          itemCount: ctrl.products.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(ctrl.products[index].name ?? ''),
              subtitle: Text((ctrl.products[index].price?? 0).toString()),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ctrl.deleteProduct(ctrl.products[index].id ?? '');
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(const AddProductPage());
            },
            child: const Icon(Icons.add_box_rounded)
        ),
      );
    });
  }
}