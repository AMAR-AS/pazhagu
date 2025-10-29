
// lib/screens/updates/updates_screen.dart

import 'package:flutter/material.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
      ),
      body: const Center(
        child: Text('Updates will be displayed here.'),
      ),
    );
  }
}
