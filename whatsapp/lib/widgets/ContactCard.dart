import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/pages/IndividualChatPage.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chatModel;

  ContactCard(this.chatModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Container(
          height: 53,
          width: 50,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 23,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueGrey[200],
              ),
              chatModel.selected ? Positioned(
                bottom: 5,
                right: 4,
                child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 15,
                    )),
              ): Container()
            ],
          ),
        ),
        title: Text(chatModel.name,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle: Text(chatModel.status, style: TextStyle(fontSize: 13)),
      ),
    );
  }
}
