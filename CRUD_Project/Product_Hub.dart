import 'package:assignment_mod_16/CRUD_Project/Product_design.dart';
import 'package:flutter/material.dart';

class Product_Hub extends StatelessWidget {
  final Data Product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const Product_Hub({
    super.key,
    required this.Product,
    required this.onDelete,
    required this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Image.network(
                Product.img != null && Product.img.toString().startsWith('http')  ?
                Product.img.toString() : ('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZzKa_3FYC14X97EPiR_eLfmnyBYJ4sv1QKg&s')),
          ),
          Text(Product.productName.toString(),
            style: TextStyle(
                height: 2,
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold
            ),
          ),
          Text('Price: \$${Product.unitPrice} | QTY: ${Product.qty}',
            style: TextStyle(
                fontSize: 16,
                color: Colors.black87
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: onEdit, icon: Icon(Icons.edit_note,color: Colors.green,)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete,color: Colors.red,))
            ],
          )
        ],
      ),
    );
  }
}