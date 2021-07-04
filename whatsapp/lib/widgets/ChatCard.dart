import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/pages/IndividualChatPage.dart';

class ChatCard extends StatelessWidget {

  final ChatModel chatModel;
  final int sourceId;
  const ChatCard({Key key, this.chatModel, this.sourceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualChatPage(chatModel: chatModel, sourceId: sourceId,)));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(chatModel.isGroup ? Icons.group : Icons.person,
              color: Colors.white,
              size: 37,),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 5,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                )
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80.0, right: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
