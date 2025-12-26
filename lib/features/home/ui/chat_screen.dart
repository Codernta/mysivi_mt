import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysivi_mt/features/home/models/user_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  final List<MessageModel> messages;


  const ChatScreen({super.key, required this.user, required this.messages});


  @override
  State<ChatScreen> createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();


  Future<String> fetchReceiverMessage() async {
    final res = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=1'));
    final data = jsonDecode(res.body);
    return data[0]['body'];
  }


  void sendMessage() async {
    if (controller.text.isEmpty) return;
    setState(() {
      widget.messages.add(MessageModel(
          text: controller.text,
          isSender: true,
          time: DateTime.now()));
    });
    controller.clear();


    try {
      final reply = await fetchReceiverMessage();
      setState(() {
        widget.messages.add(MessageModel(
            text: reply, isSender: false, time: DateTime.now()));
      });
    } catch (_) {
      setState(() {
        widget.messages.add(MessageModel(
            text: 'Failed to load message',
            isSender: false,
            time: DateTime.now()));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.name)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (_, i) {
                final msg = widget.messages[i];
                return Align(
                  alignment:
                  msg.isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!msg.isSender)
                          CircleAvatar(child: Text(widget.user.name[0])),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: msg.isSender
                                ? Colors.blue
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(msg.text,
                              style: TextStyle(
                                  color: msg.isSender
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        if (msg.isSender)
                          const CircleAvatar(child: Text('Me')),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration:
                  const InputDecoration(hintText: 'Type a message'),
                ),
              ),
              IconButton(icon: const Icon(Icons.send), onPressed: sendMessage)
            ],
          )
        ],
      ),
    );
  }
}