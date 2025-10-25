import 'package:assignment_mod_16/CRUD_Project/Product_Controller.dart';
import 'package:flutter/material.dart';

import 'Product_Hub.dart';
class App_Structure extends StatefulWidget {
  const App_Structure({super.key});

  @override
  State<App_Structure> createState() => _App_StructureState();
}

class _App_StructureState extends State<App_Structure> {
  Product_Controller ProController = Product_Controller();

  Future RealData() async{
    await ProController.Real_View();
    setState(() {

    });
  }

  ProductADD({String ? id,String ? name,String ? img,int ? qty,int ? uniPrice,int
  ? totalPrice, required bool isUpdate}){
    TextEditingController productNameController =
    TextEditingController(text: name);
    TextEditingController productIMGController =
    TextEditingController(text: img);
    TextEditingController productQTYController =
    TextEditingController(text: qty != null ? qty.toString() : '');
    TextEditingController productUnitPriceController = TextEditingController(
        text: uniPrice != null ? uniPrice.toString() : '');
    TextEditingController productTotalPriceController = TextEditingController(
        text: totalPrice != null ? totalPrice.toString() : '');
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(isUpdate ? 'Update product' : 'Add product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: productIMGController,
                decoration: InputDecoration(labelText: 'Product img'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: productQTYController,
                decoration: InputDecoration(labelText: 'Product qty'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: productUnitPriceController,
                decoration:
                InputDecoration(labelText: 'Product unit price'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: productTotalPriceController,
                decoration:
                InputDecoration(labelText: 'Product total price'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  ElevatedButton(
                      onPressed: () async {
                        if (isUpdate) {
                          await Product_Controller.dele(
                              id.toString(),
                              productNameController.text,
                              productIMGController.text,
                              int.parse(productQTYController.text),
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text));
                        } else {
                          await ProController.deleteProduct(
                              productNameController.text,
                              productIMGController.text,
                              int.parse(productQTYController.text),
                              int.parse(productUnitPriceController.text),
                              int.parse(productTotalPriceController.text));
                        }

                        await RealData();
                        Navigator.pop(context);
                      },
                      child: Text('Save'))
                ],
              )
            ],
          ),
        ));
  }

  @override
  void initState(){
    super.initState();
    RealData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Project'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.90
          ),
          itemCount: ProController.Product.length,
          itemBuilder: (context,index){
            var Products = ProController.Product[index];
            return Product_Hub(Product: Products, onDelete: (){
              ProController.deleteProduct(Products.sId.toString()).then((value) async {
                if(value){
                  await ProController.Real_View();
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product Delete'),)
                    );
                  });
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Something Worng..!!!'),
                    )
                  );
                }
              });
            },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ProductADD(isUpdate: false),
        child: Icon(Icons.add_circle,),
      )
    );
  }
}


