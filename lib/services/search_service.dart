
// lib/services/search_service.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class SearchService extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void search(String query, NavItem currentItem) {
    _searchQuery = query;

    if (currentItem == NavItem.media) {
      // TODO: Implement username search logic
      print('Searching for username: $query');
    } else {
      // TODO: Implement generic search logic (chats, files, etc.)
      print('Searching for: $query');
    }

    notifyListeners();
  }
}
