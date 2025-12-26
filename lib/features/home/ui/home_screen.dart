import 'package:flutter/material.dart';
import 'package:mysivi_mt/features/home/models/user_model.dart';
import 'package:mysivi_mt/features/home/ui/tabs/chat_history_tab.dart';
import 'package:mysivi_mt/features/home/ui/tabs/user_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int topTabIndex = 0;
  final List<UserModel> users = [];
  final Map<String, List<MessageModel>> chats = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: _TopSwitcher(
                index: topTabIndex,
                onChanged: (i) => setState(() => topTabIndex = i),
              ),
              centerTitle: true,
            )
          ];
        },
        body: IndexedStack(
          index: topTabIndex,
          children: [
            UsersTab(users: users, chats: chats),
            ChatHistoryTab(chats: chats),
          ],
        ),
      ),
      floatingActionButton: topTabIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          final name = 'User ${users.length + 1}';
          setState(() => users.add(UserModel(name)));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User added: $name')));
        },
        child: const Icon(Icons.add),
      )
          : null,
    );
  }
}

class _TopSwitcher extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _TopSwitcher({required this.index, required this.onChanged});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _switchButton('Users', 0),
          _switchButton('History', 1),
        ],
      ),
    );
  }


  Widget _switchButton(String label, int i) {
    final selected = index == i;
    return GestureDetector(
      onTap: () => onChanged(i),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label,
            style: TextStyle(color: selected ? Colors.white : Colors.black)),
      ),
    );
  }
}