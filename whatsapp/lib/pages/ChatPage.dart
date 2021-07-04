import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/pages/SelectContactPage.dart';
import 'package:whatsapp/widgets/ChatCard.dart';

class ChatPage extends StatefulWidget {
  final int sourceId;
  const ChatPage({this.sourceId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectContactPage(sourceId: widget.sourceId)));
          },
          child: Icon(Icons.chat),
        ),
        body: ListView.builder(
          itemCount: Constants.chatModels.length,
          itemBuilder: (context, index) {
            if (Constants.chatModels[index].id != widget.sourceId) {
              return ChatCard(chatModel: Constants.chatModels[index], sourceId: widget.sourceId,);
            } else {

              return Container();
            }
          },
        ));
  }
}
