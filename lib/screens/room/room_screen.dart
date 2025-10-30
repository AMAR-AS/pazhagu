
// lib/screens/room/room_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/room/local_audio_screen.dart';
import 'package:pazhagu/screens/room/local_video_screen.dart';
import 'package:pazhagu/screens/room/online_music_screen.dart';
import 'package:pazhagu/screens/room/online_video_screen.dart';
import 'package:pazhagu/widgets/styled_container.dart';

enum RoomView { list, grid, bar }

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  RoomView _view = RoomView.grid;
  int _selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<RoomView>(
                icon: const Icon(Icons.view_list),
                onSelected: (RoomView result) {
                  setState(() {
                    _view = result;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<RoomView>>[
                  const PopupMenuItem<RoomView>(
                    value: RoomView.list,
                    child: Text('List'),
                  ),
                  const PopupMenuItem<RoomView>(
                    value: RoomView.grid,
                    child: Text('Grid'),
                  ),
                  const PopupMenuItem<RoomView>(
                    value: RoomView.bar,
                    child: Text('Bar'),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildRoomContent(),
        ),
        _buildRecents(),
      ],
    );
  }

  Widget _buildRoomContent() {
    switch (_view) {
      case RoomView.list:
        return _buildRoomList();
      case RoomView.grid:
        return _buildRoomGrid();
      case RoomView.bar:
        return _buildRoomBar();
    }
  }

  Widget _buildRoomList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildRoomCard(context, '🎵', 'Online Music', const OnlineMusicScreen(), view: RoomView.list),
        _buildRoomCard(context, '🎬', 'Online Video', const OnlineVideoScreen(), view: RoomView.list),
        _buildRoomCard(context, '🎧', 'Local Audio', const LocalAudioScreen(), view: RoomView.list),
        _buildRoomCard(context, '📹', 'Local Video', const LocalVideoScreen(), view: RoomView.list),
      ],
    );
  }

  Widget _buildRoomGrid() {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildRoomCard(context, '🎵', 'Online Music', const OnlineMusicScreen(), view: RoomView.grid),
        _buildRoomCard(context, '🎬', 'Online Video', const OnlineVideoScreen(), view: RoomView.grid),
        _buildRoomCard(context, '🎧', 'Local Audio', const LocalAudioScreen(), view: RoomView.grid),
        _buildRoomCard(context, '📹', 'Local Video', const LocalVideoScreen(), view: RoomView.grid),
      ],
    );
  }

  Widget _buildRoomBar() {
    final items = [
      {'emoji': '🎵', 'title': 'Online Music', 'screen': const OnlineMusicScreen()},
      {'emoji': '🎬', 'title': 'Online Video', 'screen': const OnlineVideoScreen()},
      {'emoji': '🎧', 'title': 'Local Audio', 'screen': const LocalAudioScreen()},
      {'emoji': '📹', 'title': 'Local Video', 'screen': const LocalVideoScreen()},
    ];

    return StyledContainer(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          final int index = items.indexOf(item);
          final bool isSelected = _selectedBarIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedBarIndex = index;
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) => item['screen'] as Widget));
            },
            child: StyledContainer(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Text(item['emoji'] as String, style: const TextStyle(fontSize: 24)),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String emoji, String title, Widget screen, {required RoomView view}) {
    switch (view) {
      case RoomView.list:
        return StyledContainer(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Text(emoji, style: const TextStyle(fontSize: 24)),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
          ),
        );
      case RoomView.grid:
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
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRecents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Recents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Dummy data
            itemBuilder: (context, index) {
              return StyledContainer(
                margin: const EdgeInsets.all(8),
                child: const SizedBox(
                  width: 100,
                  child: Center(child: Text('Recent file')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
