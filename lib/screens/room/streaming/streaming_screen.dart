
// lib/screens/room/streaming/streaming_screen.dart

import 'package:flutter/material.dart';

class StreamingScreen extends StatelessWidget {
  const StreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaming'),
      ),
      body: const Center(
        child: Text('Streaming content will be displayed here.'),
      ),
    );
  }
}
