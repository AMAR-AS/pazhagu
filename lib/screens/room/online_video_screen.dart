
// lib/screens/room/online_video_screen.dart

import 'package:flutter/material.dart';

class OnlineVideoScreen extends StatelessWidget {
  const OnlineVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Video'),
      ),
      body: const Center(
        child: Text('Online video streaming will be integrated here.'),
      ),
    );
  }
}
