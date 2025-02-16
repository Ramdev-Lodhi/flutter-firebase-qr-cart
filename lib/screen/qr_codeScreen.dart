import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodescreen extends StatelessWidget {
  final String qrCodeId;
  QrCodescreen({required this.qrCodeId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('QR Code:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        QrImageView(
          data: qrCodeId,
          size: 200,
        ),
      ],
    );
  }
}
