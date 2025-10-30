
// lib/models/story_model.dart

class Story {
  final String id;
  final String userId;
  final String mediaUrl;
  final String mediaType;
  final DateTime timestamp;

  Story({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.timestamp,
  });
}
