
// lib/models/chat_model.dart

import 'package:pazhagu/models/message_model.dart';

class Chat {
  final String id;
  final List<String> userIds;
  final Message? lastMessage;
  final String lastMessageTime;
  final bool isLocked;

  Chat({
    required this.id,
    required this.userIds,
    this.lastMessage,
    required this.lastMessageTime,
    this.isLocked = false,
  });
}
