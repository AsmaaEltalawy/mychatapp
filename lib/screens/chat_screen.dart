import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/services/auth_services.dart';

import '../wedgets/my_message.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final authServicesObject = AuthServices();

  final controller = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
  }

  void logout() {
    authServicesObject.logout();
  }

  void addMessage() {
    if (controller.text.isEmpty) {
      return;
    } else {
      _db.collection('chats').add({
        'userId': user?.uid,
        'message': controller.text,
        'timestamp': FieldValue.serverTimestamp()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF264131),
        foregroundColor: Colors.white,
        title: Text(
          'Chat App',
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: logout,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream:
                    _db.collection('chats').orderBy('timestamp').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      color: Color(0xFF264131),
                    );
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (ctx, index) {
                        var newMessage = messages[index];
                        bool isMe = newMessage['userId'] == user?.uid;

                        return MyMessage(
                            message: newMessage['message'], isMe: isMe);
                      });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF264131),))),
                  ),
                ),
                IconButton(onPressed: addMessage, icon: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
