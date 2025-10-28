
// lib/screens/profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/profile/widgets/profile_header.dart';
import 'package:pazhagu/screens/profile/widgets/profile_info.dart';
import 'package:pazhagu/screens/profile/widgets/profile_posts_grid.dart';
import 'package:pazhagu/screens/profile/widgets/profile_stats.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ProfileHeader(username: 'YourUsername'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileInfo(
              name: 'Your Name',
              bio: 'This is your bio. You can write a short description about yourself here.',
              profilePictureUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
            ),
            ProfileStats(
              postCount: 120,
              followerCount: 5600,
              followingCount: 340,
            ),
            Divider(),
            ProfilePostsGrid(),
          ],
        ),
      ),
    );
  }
}
