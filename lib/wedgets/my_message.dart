import 'package:flutter/material.dart';
import 'package:mychatapp/services/firestore_services.dart';

class MyMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String messageId;
  final fireStore = FireStoreServices();

  MyMessage(
      {super.key,
      required this.message,
      required this.isMe,
      required this.messageId});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onDoubleTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Delete Message'),
              content: Text('Do you want to delete this message?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // يقفل الديالوج من غير حذف
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    fireStore.deleteMessage(messageId);
                    Navigator.pop(context); // يقفل الديالوج بعد التنفيذ
                    print('Message deleted'); // مؤقتًا بنطبع بس
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Color(0xFF264131) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
