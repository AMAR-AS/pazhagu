

// lib/screens/moments/moments_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/models/moment_model.dart';
import 'package:pazhagu/screens/stories/channels_screen.dart';
import 'package:pazhagu/screens/stories/community_screen.dart';
import 'package:pazhagu/screens/stories/memories_screen.dart';
import 'package:pazhagu/screens/stories/story_view_screen.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class MomentsScreen extends StatefulWidget {
  const MomentsScreen({Key? key}) : super(key: key);

  @override
  State<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends State<MomentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = true;
  int _internalTabIndex = 0;
  List<Moment> _moments = [
    Moment(
      id: '1',
      userId: 'user1',
      mediaUrl: 'https://picsum.photos/seed/1/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Moment(
      id: '2',
      userId: 'user2',
      mediaUrl: 'https://picsum.photos/seed/2/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      visited: true,
    ),
    Moment(
      id: '3',
      userId: 'user3',
      mediaUrl: 'https://picsum.photos/seed/3/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Moment(
      id: '4',
      userId: 'user4',
      mediaUrl: 'https://picsum.photos/seed/4/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      visited: true,
    ),
    Moment(
      id: '5',
      userId: 'user5',
      mediaUrl: 'https://picsum.photos/seed/5/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Moment(
      id: '6',
      userId: 'user6',
      mediaUrl: 'https://picsum.photos/seed/6/200/300',
      mediaType: 'image',
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      visited: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _sortMoments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _sortMoments() {
    _moments.sort((a, b) {
      if (a.visited && !b.visited) {
        return 1;
      } else if (!a.visited && b.visited) {
        return -1;
      } else {
        return b.timestamp.compareTo(a.timestamp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Moments', icon: Icon(Icons.image)),
            Tab(text: 'Community', icon: Icon(Icons.group)),
            Tab(text: 'Channels', icon: Icon(Icons.cast)),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildMomentsTab(),
              const CommunityScreen(),
              const ChannelsScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMomentsTab() {
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
          child: _internalTabIndex == 0 ? _buildMomentsContent() : const MemoriesScreen(),
        ),
      ],
    );
  }

  Widget _buildInternalTab() {
    return Row(
      children: [
        _buildInternalTabButton(0, Icons.image, 'Moments'),
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

  Widget _buildMomentsContent() {
    return _isGridView ? _buildMomentsGrid() : _buildMomentsList();
  }

  Widget _buildMomentsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.all(8),
      itemCount: _moments.length,
      itemBuilder: (context, index) {
        final moment = _moments[index];
        return StyledContainer(
          onTap: () {
            setState(() {
              moment.visited = true;
              _sortMoments();
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StoryViewScreen()),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  moment.mediaUrl,
                  fit: BoxFit.cover,
                ),
              ),
              if (!moment.visited)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                ),
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
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Text(
                  moment.userId,
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
    );
  }

  Widget _buildMomentsList() {
    return ListView.builder(
      itemCount: _moments.length,
      itemBuilder: (context, index) {
        final moment = _moments[index];
        return StyledContainer(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(moment.mediaUrl),
              child: !moment.visited
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                    )
                  : null,
            ),
            title: Text(moment.userId),
            onTap: () {
              setState(() {
                moment.visited = true;
                _sortMoments();
              });
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
