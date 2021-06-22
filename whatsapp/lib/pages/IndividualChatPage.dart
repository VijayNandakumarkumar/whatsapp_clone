import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';

class IndividualChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const IndividualChatPage({Key key, this.chatModel}) : super(key: key);

  @override
  _IndividualChatPageState createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
