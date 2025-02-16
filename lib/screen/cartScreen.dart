import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technorizen_machine_task_ecom/screen/addProductScreen.dart';
import 'package:technorizen_machine_task_ecom/screen/detailsProductScreen.dart';
import 'package:technorizen_machine_task_ecom/screen/qr_scannerScreen.dart';

class Cartscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Commerce')),
      body: Column(
        children: [
          SizedBox(height: 8),
          Text(
            "ALL CART LIST",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 600,
            child: StreamBuilder<QuerySnapshot>(
              stream:
              FirebaseFirestore.instance.collection('carts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No Products Found'));
                }

                var products = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var product =
                    products[index].data() as Map<String, dynamic>;
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        title: Text(product['name']),
                        subtitle: Text("₹ ${product['price']}"),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Detailsproductscreen(product['qrCodeId']),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
