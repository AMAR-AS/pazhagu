
// lib/screens/storage/backup_options_screen.dart

import 'package:flutter/material.dart';

class BackupOptionsScreen extends StatelessWidget {
  const BackupOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup Options'),
      ),
      body: const Center(
        child: Text('Backup options will be displayed here.'),
      ),
    );
  }
}
