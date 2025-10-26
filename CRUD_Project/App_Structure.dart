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
    TextEditingController ProductNameCon = TextEditingController();
    TextEditingController ProductImgCon = TextEditingController();
    TextEditingController ProductQtyCon = TextEditingController();
    TextEditingController ProductUnitPriCon = TextEditingController();
    TextEditingController ProductTotalPriCon = TextEditingController();
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text(isUpdate ? 'Update product' : 'Add Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: ProductNameCon,
            decoration: InputDecoration(
              labelText: 'Product Name'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ProductImgCon,
            decoration: InputDecoration(
                labelText: 'Product Image'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ProductQtyCon,
            decoration: InputDecoration(
                labelText: 'Product Quantity'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ProductUnitPriCon,
            decoration: InputDecoration(
                labelText: 'Product Unit Price'
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ProductTotalPriCon,
            decoration: InputDecoration(
                labelText: 'Product Total Price'
            ),
          ),
          SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){Navigator.pop(context);},
                  child: Text('Cancel')),
              ElevatedButton(onPressed: () async {
                await ProController.createProduct(ProductNameCon.text, ProductImgCon.text, int.parse(ProductQtyCon.text), int.parse(ProductUnitPriCon.text), int.parse(ProductTotalPriCon.text))
              }, child: Text('Save'))
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
          onPressed: () {
            ProductADD(isUpdate: false);
          },
          child: Icon(Icons.add_circle),
        )

    );
  }
}


