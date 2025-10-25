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

  Future <bool> deleteProduct(String ProductID, String text) async {
    final response = await http.get(Uri.parse(Urls.deleteProduct(ProductID)));

    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }

  static Future<void> dele(String string, String text, String text2, int parse, int parse2, int parse3) async {}
}