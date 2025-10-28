
// lib/screens/room/local_video_screen.dart

import 'package:flutter/material.dart';

class LocalVideoScreen extends StatelessWidget {
  const LocalVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Video'),
      ),
      body: const Center(
        child: Text('Local video player will be implemented here.'),
      ),
    );
  }
}
