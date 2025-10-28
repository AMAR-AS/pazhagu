
// lib/screens/ai_hub/ai_hub_screen.dart

import 'package:flutter/material.dart';

class AiHubScreen extends StatelessWidget {
  const AiHubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Hub'),
      ),
      body: const Center(
        child: Text('AI Hub features will be displayed here.'),
      ),
    );
  }
}
