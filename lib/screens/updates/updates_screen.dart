
// lib/screens/updates/updates_screen.dart

import 'package:flutter/material.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
      ),
      body: Center(
        child: Text('Updates Screen'),
      ),
    );
  }
}
