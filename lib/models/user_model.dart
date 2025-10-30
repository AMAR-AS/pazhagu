
// lib/models/user_model.dart

class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final String profilePictureUrl;
  final String bio;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.bio,
  });
}
