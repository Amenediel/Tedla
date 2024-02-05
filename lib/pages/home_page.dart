import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tedla_client/controller/home_controller.dart';
import 'package:tedla_client/pages/login_page.dart';
import 'package:tedla_client/pages/product_description_page.dart';
import 'package:tedla_client/widgets/drop_down_btn.dart';
import 'package:tedla_client/widgets/multi_select_drop_down.dart';
import 'package:tedla_client/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async{
          ctrl.fetchProduct();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: Text("Tedla", style: TextStyle(fontWeight: FontWeight.bold),),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {
                GetStorage box = GetStorage();
                box.erase();
                Get.offAll(LoginPage());
              }, icon: Icon(Icons.login_rounded)),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.amberAccent[200],
                child: SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.productCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {ctrl.filterByCategory(ctrl.productCategories[index].name ?? '');},
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Chip(label: Text(ctrl.productCategories[index].name ?? 'Error')),
                          ),
                        );
                      }),

                ),
              ),
              Container(
                color: Colors.amberAccent[200],
                child: Row(
                  children: [
                    Flexible(child: MultiSelectDropDown(
                      items: ['item1', 'item2', 'item3'],
                      onSelectedChanged: (selectedItems) {
                        print(selectedItems);
                      },)),
                    Flexible(
                      child: DropDown(
                        items: ['ETB: Low to High', 'ETB: High to Low'],
                        onSelected: (selected) {

                          ctrl.sortByPrice(ascending: selected == 'ETB: Low to High' ? true : false);
                        },
                        hintText: 'Sort',),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                  return ProductCard(name: ctrl.productShowInUi[index].name ?? 'No name',
                    imageUrl: ctrl.productShowInUi[index].image ?? 'No image',
                    price: ctrl.productShowInUi[index].price ?? 0,
                    offerTag: '30% off',
                    onTap: () {
                      Get.to(ProductDescriptionPage(),arguments: {'data':ctrl.productShowInUi[index]});
                    },);
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
