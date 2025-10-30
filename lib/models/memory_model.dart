
// lib/models/memory_model.dart

class Memory {
  final String id;
  final String storyId;
  final bool isPublic;

  Memory({
    required this.id,
    required this.storyId,
    this.isPublic = false,
  });
}
