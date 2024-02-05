import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tedla_app/controller/home_controller.dart';
import 'package:tedla_app/widgets/drop_down_btn.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Add New Product",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Product Name",
                    hintText: "Enter the product name",
                  ),
                ),
                const SizedBox(height: 10.0,),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Product Description",
                    hintText: "Enter the product description",
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 10.0,),
                TextField(
                  controller: ctrl.productImageCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Image URL",
                    hintText: "Enter the product image address",
                  ),
                ),
                const SizedBox(height: 10.0,),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Product Price",
                    hintText: "Enter the product price",
                  ),
                ),
                const SizedBox(height: 10.0,),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: DropDown(
                        items: const [
                          'Hoodie',
                          'Sweater',
                          'T-shirt',
                          'Sweatpant',
                          'Other'
                        ],
                        hintText: 'Catagory',
                        onSelected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'General';

                        },
                      ),
                    ),
                    Flexible(
                      child: DropDown(
                        items: const ['Cotton', 'Polyester', 'Wool', 'Nylon'],
                        hintText: 'Material',
                        onSelected: (selectedValue) {
                          ctrl.material = selectedValue ?? 'None';

                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                const Text("Offer Available?"),
                DropDown(items: ['true', 'false'],
                  hintText: 'Offer',
                  onSelected: (selectedValue) {
                    ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                  },),
                const SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.brown,
                    ),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: const Text("Add Product")),
              ],
            ),
          ),
        ),
      );
    });
  }
}