
// lib/screens/media/media_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/media/quickshots_screen.dart';
import 'package:pazhagu/screens/media/updates_screen.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.whatshot), text: 'Updates'),
              Tab(icon: Icon(Icons.flash_on), text: 'Quickshots'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UpdatesScreen(),
            QuickshotsScreen(),
          ],
        ),
      ),
    );
  }
}
