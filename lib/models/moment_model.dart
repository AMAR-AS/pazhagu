
// lib/models/moment_model.dart

class Moment {
  final String id;
  final String userId;
  final String mediaUrl;
  final String mediaType;
  final DateTime timestamp;
  bool visited;

  Moment({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    required this.mediaType,
    required this.timestamp,
    this.visited = false,
  });
}
