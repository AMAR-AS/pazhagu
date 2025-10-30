

// lib/screens/stories/stories_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/stories/channels_screen.dart';
import 'package:pazhagu/screens/stories/community_screen.dart';
import 'package:pazhagu/screens/stories/memories_screen.dart';
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
  bool _isGridView = true;
  int _internalTabIndex = 0;

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInternalTab(),
              IconButton(
                icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                onPressed: () {
                  setState(() {
                    _isGridView = !_isGridView;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: _internalTabIndex == 0 ? _buildStoriesContent() : const MemoriesScreen(),
        ),
      ],
    );
  }

  Widget _buildInternalTab() {
    return Row(
      children: [
        _buildInternalTabButton(0, Icons.image, 'Stories'),
        _buildInternalTabButton(1, Icons.movie, 'Memories'),
      ],
    );
  }

  Widget _buildInternalTabButton(int index, IconData icon, String text) {
    final bool isActive = _internalTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _internalTabIndex = index;
        });
      },
      child: StyledContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18),
            if (isActive)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesContent() {
    return _isGridView ? _buildStoriesGrid() : _buildStoriesList();
  }

  Widget _buildStoriesGrid() {
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

  Widget _buildStoriesList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        final String username = 'User ${index + 1}';
        return StyledContainer(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/seed/${index + 1}/200/300'),
            ),
            title: Text(username),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StoryViewScreen()),
              );
            },
          ),
        );
      },
    );
  }
}
