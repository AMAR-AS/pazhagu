
// lib/screens/stories/memories_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/models/memory_model.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for memories
    final List<Memory> memories = [];

    if (memories.isEmpty) {
      return const Center(
        child: Text('No memories stored yet.'),
      );
    } else {
      return ListView.builder(
        itemCount: memories.length,
        itemBuilder: (context, index) {
          final memory = memories[index];
          return ListTile(
            title: Text(memory.storyId),
          );
        },
      );
    }
  }
}
