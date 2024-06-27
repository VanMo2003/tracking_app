import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreent extends StatefulWidget {
  const MessageScreent({super.key});

  @override
  State<MessageScreent> createState() => _MessageScreentState();
}

class _MessageScreentState extends State<MessageScreent> {
  Map payload = {};
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
    }

    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Message"),
      ),
      body: Center(
        child: Text(payload.toString()),
      ),
    );
  }
}
