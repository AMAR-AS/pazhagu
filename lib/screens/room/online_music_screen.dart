
// lib/screens/room/online_music_screen.dart

import 'package:flutter/material.dart';

class OnlineMusicScreen extends StatelessWidget {
  const OnlineMusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Music'),
      ),
      body: const Center(
        child: Text('Online music streaming will be integrated here.'),
      ),
    );
  }
}
