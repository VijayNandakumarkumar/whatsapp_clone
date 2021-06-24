import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chatModel;

  ContactCard(this.chatModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueGrey[200],
        ),
        title: Text(chatModel.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle: Text(chatModel.status, style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
