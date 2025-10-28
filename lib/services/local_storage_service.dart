
// lib/services/local_storage_service.dart

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class LocalStorageService extends ChangeNotifier {
  Database? _database;
  final ModeProvider _modeProvider;
  final SettingsProvider _settingsProvider;

  Database? get database => _database;

  LocalStorageService(this._modeProvider, this._settingsProvider) {
    _modeProvider.addListener(_onModeChanged);
    _settingsProvider.addListener(_onModeChanged);
    _initDatabase();
  }

  void _onModeChanged() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    if (kIsWeb) return;

    final dbName = _getDbName();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE messages (
            id TEXT PRIMARY KEY,
            chatId TEXT NOT NULL,
            senderId TEXT NOT NULL,
            content TEXT NOT NULL,
            encrypted TEXT NOT NULL,
            timestamp TEXT NOT NULL,
            mode TEXT NOT NULL,
            viewOnce INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE chats (
            id TEXT PRIMARY KEY,
            userId TEXT NOT NULL,
            contactId TEXT NOT NULL,
            contactName TEXT NOT NULL,
            lastMessage TEXT,
            lastMessageTime TEXT,
            mode TEXT NOT NULL,
            isLocked INTEGER DEFAULT 0
          )
        ''');

        await db.execute('''
          CREATE TABLE posts (
            id TEXT PRIMARY KEY,
            userId TEXT NOT NULL,
            content TEXT NOT NULL,
            mediaUrl TEXT,
            mediaType TEXT,
            likes INTEGER DEFAULT 0,
            comments INTEGER DEFAULT 0,
            timestamp TEXT NOT NULL,
            mode TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE events (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            startTime TEXT NOT NULL,
            endTime TEXT NOT NULL,
            mode TEXT NOT NULL,
            reminder INTEGER DEFAULT 0
          )
        ''');
      },
    );
    notifyListeners();
  }

  String _getDbName() {
    if (_settingsProvider.isIsolatedMode) {
      return 'pazhagu_${_modeProvider.currentMode.name.toLowerCase()}.db';
    } else {
      return 'pazhagu.db';
    }
  }

  Future<int> insertMessage(Map<String, dynamic> message) async {
    if (_database == null) return 0;
    return await _database!.insert('messages', message);
  }

  Future<List<Map<String, dynamic>>> getMessages(
      String chatId,
      String mode,
      ) async {
    if (_database == null) return [];
    return await _database!.query(
      'messages',
      where: 'chatId = ? AND mode = ?',
      whereArgs: [chatId, mode],
      orderBy: 'timestamp DESC',
    );
  }

  Future<int> insertChat(Map<String, dynamic> chat) async {
    if (_database == null) return 0;
    return await _database!.insert('chats', chat);
  }

  Future<List<Map<String, dynamic>>> getChats(String mode) async {
    if (_database == null) return [];
    return await _database!.query(
      'chats',
      where: 'mode = ?',
      whereArgs: [mode],
      orderBy: 'lastMessageTime DESC',
    );
  }

  Future<int> insertPost(Map<String, dynamic> post) async {
    if (_database == null) return 0;
    return await _database!.insert('posts', post);
  }

  Future<List<Map<String, dynamic>>> getPosts(String mode) async {
    if (_database == null) return [];
    return await _database!.query(
      'posts',
      where: 'mode = ?',
      whereArgs: [mode],
      orderBy: 'timestamp DESC',
    );
  }

  Future<int> insertEvent(Map<String, dynamic> event) async {
    if (_database == null) return 0;
    return await _database!.insert('events', event);
  }

  Future<List<Map<String, dynamic>>> getEvents(
      String mode,
      String date,
      ) async {
    if (_database == null) return [];
    return await _database!.query(
      'events',
      where: 'mode = ? AND startTime LIKE ?',
      whereArgs: [mode, '$date%'],
      orderBy: 'startTime ASC',
    );
  }

  @override
  void dispose() {
    _modeProvider.removeListener(_onModeChanged);
    _settingsProvider.removeListener(_onModeChanged);
    _database?.close();
    super.dispose();
  }
}
