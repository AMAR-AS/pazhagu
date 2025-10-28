// lib/screens/chats_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/services/local_storage_service.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ModeProvider, LocalStorageService>(
      builder: (context, modeProvider, localStorageService, _) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: localStorageService.getChats(modeProvider.currentMode.name.toLowerCase()),
          builder: (context, snapshot) {
            if (localStorageService.database == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final chats = snapshot.data ?? [];

            if (chats.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement new chat functionality
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('New Chat'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (modeProvider.currentMode.icon != null)
                            Icon(
                              modeProvider.currentMode.icon,
                              size: 64,
                              color: Colors.grey,
                            )
                          else if (modeProvider.currentMode.emoji != null)
                            Text(modeProvider.currentMode.emoji!, style: const TextStyle(fontSize: 64)),
                          const SizedBox(height: 16),
                          const Text('No chats yet'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 120.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement new chat functionality
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text('New Chat'),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chat = chats[index];
                      return _buildChatTile(chat);
                    },
                    childCount: chats.length,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return StyledContainer(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(chat['contactName'][0].toUpperCase()),
        ),
        title: Text(chat['contactName']),
        subtitle: Text(
          chat['lastMessage'] ?? 'No messages',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat['lastMessageTime'] ?? '',
              style: const TextStyle(fontSize: 12),
            ),
            if (chat['unread'] != null && chat['unread'] > 0)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  chat['unread'].toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
          ],
        ),
        onTap: () {
          // Open chat
        },
      ),
    );
  }
}
