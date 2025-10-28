
// lib/services/api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String BASE_URL = 'https://your-domain.com/api/v1';

  static Future<Map<String, dynamic>> register(
      String username,
      String email,
      String password,
      ) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Registration failed');
    }
  }

  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }

  static Future<List<dynamic>> getChats(String token, String mode) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/chats?mode=$mode'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch chats');
    }
  }

  static Future<void> sendMessage(
      String token,
      int receiverId,
      String content,
      String encrypted,
      String mode,
      ) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/messages'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'receiver_id': receiverId,
        'content': content,
        'encrypted': encrypted,
        'mode': mode,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }

  static Future<List<dynamic>> getPosts(String token, String mode) async {
    final response = await http.get(
      Uri.parse('$BASE_URL/posts?mode=$mode'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  static Future<void> createPost(
      String token,
      String content,
      String? mediaUrl,
      String mode,
      ) async {
    final response = await http.post(
      Uri.parse('$BASE_URL/posts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({
        'content': content,
        'media_url': mediaUrl,
        'mode': mode,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create post');
    }
  }
}
