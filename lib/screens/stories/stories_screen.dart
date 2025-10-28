

// lib/screens/stories/stories_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/stories/channels_screen.dart';
import 'package:pazhagu/screens/stories/community_screen.dart';
import 'package:pazhagu/screens/stories/story_view_screen.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Stories', icon: Icon(Icons.image)),
            Tab(text: 'Community', icon: Icon(Icons.group)),
            Tab(text: 'Channels', icon: Icon(Icons.cast)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildStoriesTab(),
              const CommunityScreen(),
              const ChannelsScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStoriesTab() {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(
        6,
        (index) {
          // Dummy username, replace with actual data
          final String username = 'User ${index + 1}';

          return StyledContainer(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryViewScreen()),
              );
            },
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Story thumbnail (replace with actual story media)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://picsum.photos/seed/${index + 1}/200/300',
                    fit: BoxFit.cover,
                  ),
                ),
                // Black gradient overlay for text
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                // Username text
                Positioned(
                  top: 8,
                  left: 8,
                  right: 8,
                  child: Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
