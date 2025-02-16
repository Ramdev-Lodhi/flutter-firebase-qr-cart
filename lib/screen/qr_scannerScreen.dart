import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:technorizen_machine_task_ecom/screen/cartScreen.dart';


class QrScannerscreen extends StatefulWidget {
  @override
  _QrScannerscreenState createState() => _QrScannerscreenState();
}

class _QrScannerscreenState extends State<QrScannerscreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrID = "";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      print(scanData);
      setState(() {
        qrID = scanData.code;
      });
      print(qrID);
      if (qrID!.isNotEmpty) {
        DocumentSnapshot product =
            await firestore.collection('products').doc(qrID).get();
        print(product);
        if (product.exists) {
          await firestore.collection('carts').doc(qrID).set({
            'name': product['name'],
            'description': product['description'],
            'price': product['price'],
            'qrCodeId': qrID,
          });
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Product Added to Cart')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Cartscreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan result: $qrID'),
            ),
          )
        ],
      ),
    );
  }
}

