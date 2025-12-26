import 'package:flutter/material.dart';
import 'package:mysivi_mt/features/home/models/user_model.dart';
import 'package:mysivi_mt/features/home/ui/chat_screen.dart';

class UsersTab extends StatelessWidget {
  final List<UserModel> users;
  final Map<String, List<MessageModel>> chats;


  const UsersTab({super.key, required this.users, required this.chats});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('users_list'),
      itemCount: users.length,
      itemBuilder: (_, i) {
        final user = users[i];
        return ListTile(
          leading: CircleAvatar(child: Text(user.name[0])),
          title: Text(user.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: user,
                  messages: chats[user.name] ??= [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}