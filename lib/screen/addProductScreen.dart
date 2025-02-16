import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technorizen_machine_task_ecom/screen/productlistScreen.dart';


class Addproductscreen extends StatefulWidget {
  @override
  _AddproductscreenState createState() => _AddproductscreenState();
}

class _AddproductscreenState extends State<Addproductscreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? qrCodeId;
  String? productName;
  String? description;
  String? price;

  void addProduct() async {
    // String QrCodeId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore.collection('products').doc(qrCodeId).set({
      'name': productName,
      'description': description,
      'price': price,
      'qrCodeId': qrCodeId,
    });

    Navigator.pop(
      context,
      MaterialPageRoute(
          builder: (context) => Productlistscreen()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Commerce')),
      body: Column(
        children: [
          Text("ADD PRODUCT"),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                    initialValue: productName,
                    onSaved: (value) => productName = value,
                    onChanged: (value) {
                      setState(() {
                        productName = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Product Name')),
                TextFormField(
                    initialValue: description,
                    onSaved: (value) => description = value,
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Description')),
                TextFormField(
                    initialValue: price,
                    onSaved: (value) => price = value,
                    onChanged: (value) {
                      setState(() {
                        price = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Price')),
                TextFormField(
                    initialValue: qrCodeId,
                    onSaved: (value) => qrCodeId = value,
                    onChanged: (value) {
                      setState(() {
                        qrCodeId = value;
                      });
                    },
                    decoration: InputDecoration(labelText: 'QR-Code Id')),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: addProduct,
                      child: Text('Add Product'),

                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
