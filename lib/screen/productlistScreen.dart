import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technorizen_machine_task_ecom/screen/addProductScreen.dart';
import 'package:technorizen_machine_task_ecom/screen/cartScreen.dart';
import 'package:technorizen_machine_task_ecom/screen/detailsProductScreen.dart';
import 'package:technorizen_machine_task_ecom/screen/qr_scannerScreen.dart';

class Productlistscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Commerce')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Addproductscreen()),
                  );
                },
                child: Text(
                  'Add Product',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QrScannerscreen()),
                  );
                },
                child: Icon(Icons.document_scanner),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cartscreen()),
                  );
                },
                child: Icon(Icons.shopping_cart),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "ALL PRODUCTS LIST",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 600,
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detailsproductscreen(product['qrCodeId']),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            Card(
                                margin: EdgeInsets.zero,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(product['name']),
                                    ),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                )
                            ),
                            ListTile(
                              title: Text("Price: ₹ ${product['price']}"),
                              subtitle: Text("Description: ${product['description']}"),
                            ),
                          ],
                        ),
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
