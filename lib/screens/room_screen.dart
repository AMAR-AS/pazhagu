
// lib/screens/room_screen.dart

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Rectangular container for the buttons
        StyledContainer(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRoomButton(
                context,
                icon: Icons.music_note,
                label: 'Online\nMusic',
                screen: const OnlineMusicScreen(),
              ),
              _buildRoomButton(
                context,
                icon: Icons.movie,
                label: 'Online\nVideo',
                screen: const OnlineVideoScreen(),
              ),
              _buildRoomButton(
                context,
                icon: Icons.headset,
                label: 'Local\nAudio',
                screen: const LocalAudioScreen(),
              ),
              _buildRoomButton(
                context,
                icon: Icons.video_library,
                label: 'Local\nVideo',
                screen: const LocalVideoScreen(),
              ),
            ],
          ),
        ),
        
        // Header for recent log
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Recent Log',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Recent log list
        Expanded(
          child: ListView.builder(
            itemCount: 20, // Placeholder count
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.history),
                title: Text('Log Entry #${index + 1}'),
                subtitle: const Text('Details about this activity...'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRoomButton(BuildContext context, {required IconData icon, required String label, required Widget screen}) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
