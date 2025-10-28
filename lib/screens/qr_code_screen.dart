
// lib/screens/qr_code_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/services/qr_code.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Code'),
      ),
      body: Center(
        child: QrCodeService.generateQrCode('Hello, World!'),
      ),
    );
  }
}
