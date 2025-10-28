
// lib/screens/storage/cloud_storage_screen.dart

import 'package:flutter/material.dart';

class CloudStorageScreen extends StatelessWidget {
  const CloudStorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage'),
      ),
      body: const Center(
        child: Text('Cloud Storage options will be displayed here.'),
      ),
    );
  }
}
