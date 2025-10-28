
// lib/screens/room/hearing/hearing_screen.dart

import 'package:flutter/material.dart';

class HearingScreen extends StatelessWidget {
  const HearingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hearing'),
      ),
      body: const Center(
        child: Text('Hearing content will be displayed here.'),
      ),
    );
  }
}
