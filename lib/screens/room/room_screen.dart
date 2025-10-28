
// lib/screens/room/room_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/room/local_audio_screen.dart';
import 'package:pazhagu/screens/room/local_video_screen.dart';
import 'package:pazhagu/screens/room/online_music_screen.dart';
import 'package:pazhagu/screens/room/online_video_screen.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildRoomCard(
          context,
          '🎵',
          'Online Music',
          const OnlineMusicScreen(),
        ),
        _buildRoomCard(
          context,
          '🎬',
          'Online Video',
          const OnlineVideoScreen(),
        ),
        _buildRoomCard(
          context,
          '🎧',
          'Local Audio',
          const LocalAudioScreen(),
        ),
        _buildRoomCard(
          context,
          '📹',
          'Local Video',
          const LocalVideoScreen(),
        ),
      ],
    );
  }

  Widget _buildRoomCard(BuildContext context, String emoji, String title, Widget screen) {
    return StyledContainer(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
