
// lib/models/message_model.dart

class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final bool isEncrypted;
  final DateTime timestamp;
  final bool isViewOnce;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.isEncrypted,
    required this.timestamp,
    this.isViewOnce = false,
  });
}
