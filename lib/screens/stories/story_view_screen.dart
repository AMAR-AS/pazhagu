
// lib/screens/stories/story_view_screen.dart

import 'package:flutter/material.dart';

class StoryViewScreen extends StatelessWidget {
  const StoryViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story'),
      ),
      body: const Center(
        child: Text('Story content will be displayed here.'),
      ),
    );
  }
}
