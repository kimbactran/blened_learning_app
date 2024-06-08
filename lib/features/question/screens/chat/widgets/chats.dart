import 'dart:async';

import 'package:blended_learning_appmb/features/question/controllers/chat_controller.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../personalization/models/user_model.dart';

class ChatWithUser extends StatefulWidget {
  final UserModel receiver;

  const ChatWithUser({super.key, required this.receiver});
  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<ChatWithUser> {
  final chatController = Get.put(ChatController());
  List<ChatMessage> messages = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    timer =
        Timer.periodic(Duration(seconds: 15), (Timer t) => _fetchMessages());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchMessages() async {
    final List<ChatMessage> fetchedMessages =
        await chatController.fetchMessages(widget.receiver);
    setState(() {
      messages = fetchedMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiver.nameAndRole),
      ),
      body: DashChat(
        currentUser: chatController.getCurrentUser(),
        onSend: (ChatMessage m) {
          setState(() {
            chatController.createMessage(m.text, widget.receiver);
            messages.insert(0, m);
          });
        },
        messages: messages,
      ),
    );
  }
}
