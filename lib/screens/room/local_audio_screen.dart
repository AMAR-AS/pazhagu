
// lib/screens/room/local_audio_screen.dart

import 'package:flutter/material.dart';

class LocalAudioScreen extends StatelessWidget {
  const LocalAudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Audio'),
      ),
      body: const Center(
        child: Text('Local audio player will be implemented here.'),
      ),
    );
  }
}
