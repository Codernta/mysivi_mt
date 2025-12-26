import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mysivi_mt/features/home/ui/main_screen.dart';
// import 'package:http/http.dart' as http;


void main() {
  runApp(const ChatApp());
}


class ChatApp extends StatelessWidget {
  const ChatApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Chat App',
      theme: ThemeData(useMaterial3: true),
      home: const MainScreen(),
    );
  }
}