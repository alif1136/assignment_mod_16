import 'dart:convert';

import 'package:assignment_mod_16/CRUD_Project/All_Url_Links.dart';

import 'Product_design.dart';
import 'package:http/http.dart' as http;

class Product_Controller{
  List<Data>Product = [];
  Future Real_View() async {
    final response = await http.get(Uri.parse(Urls.readProduct));

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      Product_Design model = Product_Design.fromJson(data);
      Product = model.data ?? [];
    }


  }

  Future <bool> deleteProduct(String ProductID) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(ProductID)));

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> createProduct(String name, String img, int Qty, int UnitPrice, int TotalPrice) async {
    final responseuri = await http.post(
      Uri.parse(Urls.createProduct),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": Qty,
        "UnitPrice": UnitPrice,
        "TotalPrice": TotalPrice
      }),
    );
    print(responseuri.statusCode);
    print(responseuri.body);

    if (responseuri.statusCode == 200) {
      return true;
    } else {
      print('Error: ${responseuri.statusCode}');
      print('Response body: ${responseuri.body}');
      return false;
    }
  }
  Future<bool> updateProduct(String ID,String name, String img, int Qty, int UnitPrice, int TotalPrice) async {
    final responseuri = await http.post(
      Uri.parse(Urls.updateProduct(ID)),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": Qty,
        "UnitPrice": UnitPrice,
        "TotalPrice": TotalPrice
      }),
    );
    print(responseuri.statusCode);
    print(responseuri.body);

    if (responseuri.statusCode == 200) {
      return true;
    } else {
      print('Error: ${responseuri.statusCode}');
      print('Response body: ${responseuri.body}');
      return false;
    }
  }

  
}