
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  const ProfileHeader({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            username,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down),
            onSelected: (String result) {
              // TODO: Handle account switching
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'user1',
                child: Text('Account 1'),
              ),
              const PopupMenuItem<String>(
                value: 'user2',
                child: Text('Account 2'),
              ),
              const PopupMenuItem<String>(
                value: 'add_account',
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 8),
                    Text('Add Account'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
