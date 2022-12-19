import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import '../auth.dart';
import '../models/message.dart' as modelmsg;
import '../theme.dart' as theme;

class MessagesPanel extends StatelessWidget {
  const MessagesPanel({Key? key, required this.messages}) : super(key: key);

  final List<modelmsg.Message> messages;

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  Widget build(BuildContext context) {
    return Chat(
      theme: DefaultChatTheme(
        primaryColor: theme.mainColor,
      ),
      messages: messages
          .map(
            (e) => types.TextMessage(
              id: randomString(),
              text: e.text,
              createdAt: e.sentTime.millisecondsSinceEpoch,
              author: types.User(
                id: e.senderName.hashCode.toString(),
                firstName: e.senderName,
                imageUrl: e.avatarUrl,
              ),
            ),
          )
          .toList(),
      onSendPressed: (pt) {
        print("Sent: $pt");
      },
      user: types.User(
        id: Auth.currentUser.name.hashCode.toString(),
        firstName: Auth.currentUser.name,
        imageUrl: Auth.currentUser.avatarUrl,
      ),
    );
  }
}
