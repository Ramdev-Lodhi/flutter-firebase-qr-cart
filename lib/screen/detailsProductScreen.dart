import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technorizen_machine_task_ecom/screen/qr_codeScreen.dart';

class Detailsproductscreen extends StatelessWidget {
  final String qrCodeId;

  Detailsproductscreen(this.qrCodeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(qrCodeId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          var product = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Product Name', style: TextStyle(color: Colors.black)),
                        trailing: Text(product['name'],
                            style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        title: Text('Description', style: TextStyle(color: Colors.black)),
                        trailing: Text(product['description'],
                            style: TextStyle(color: Colors.black)),
                      ),
                      ListTile(
                        title: Text('Price', style: TextStyle(color: Colors.black)),
                        trailing: Text("₹ ${product['price']}",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                QrCodescreen(qrCodeId: product['qrCodeId']),
              ],
            ),
          );
        },
      ),
    );
  }
}
