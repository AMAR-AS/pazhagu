
// lib/screens/media_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/models/post_model.dart';
import 'package:pazhagu/widgets/post_widget.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  // Dummy data for the feed
  final List<Post> _posts = [
    Post(
      username: 'Alice',
      userAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
      imageUrl: 'https://picsum.photos/id/1015/600/400',
      caption: 'Beautiful scenery!',
      likes: 123,
      comments: 45,
      timestamp: '2 hours ago',
    ),
    Post(
      username: 'Bob',
      userAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
      imageUrl: 'https://picsum.photos/id/1025/600/400',
      caption: 'My new puppy! 🐶',
      likes: 456,
      comments: 78,
      timestamp: '5 hours ago',
    ),
    Post(
      username: 'Charlie',
      userAvatar: 'https://randomuser.me/api/portraits/men/3.jpg',
      imageUrl: 'https://picsum.photos/id/1035/600/400',
      caption: 'Delicious food!',
      likes: 789,
      comments: 123,
      timestamp: '1 day ago',
    ),
  ];

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
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: _posts[index]);
              },
            ),
            const Center(child: Text('Quickshots will be displayed here.')),
          ],
        ),
      ),
    );
  }
}
