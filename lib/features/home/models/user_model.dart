class UserModel {
  final String name;
  UserModel(this.name);
}


class MessageModel {
  final String text;
  final bool isSender;
  final DateTime time;


  MessageModel({required this.text, required this.isSender, required this.time});
}