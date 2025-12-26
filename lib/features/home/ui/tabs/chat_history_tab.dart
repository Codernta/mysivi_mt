import 'package:flutter/material.dart';
import 'package:mysivi_mt/features/home/models/user_model.dart';

class ChatHistoryTab extends StatelessWidget {
  final Map<String, List<MessageModel>> chats;
  const ChatHistoryTab({super.key, required this.chats});


  @override
  Widget build(BuildContext context) {
    final keys = chats.keys.toList();
    return ListView.builder(
      key: const PageStorageKey('chat_history'),
      itemCount: keys.length,
      itemBuilder: (_, i) {
        final msgs = chats[keys[i]]!;
        if (msgs.isEmpty) return const SizedBox();
        final last = msgs.last;
        return ListTile(
          leading: CircleAvatar(child: Text(keys[i][0])),
          title: Text(keys[i]),
          subtitle: Text(last.text, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Text(TimeOfDay.fromDateTime(last.time).format(context)),
        );
      },
    );
  }
}