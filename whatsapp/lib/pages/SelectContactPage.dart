import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/pages/IndividualChatPage.dart';
import 'package:whatsapp/pages/NewGroupPage.dart';
import 'package:whatsapp/widgets/ContactCard.dart';
import 'package:whatsapp/widgets/CustomContactCard.dart';

class SelectContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "126 contacts",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ]),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              )),
          PopupMenuButton(onSelected: (value) {
            print(value);
          }, itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Text("Invite a friend"),
                value: "Invite a friend",
              ),
              PopupMenuItem(
                child: Text("Contacts"),
                value: "Contacts",
              ),
              PopupMenuItem(
                child: Text("Refresf"),
                value: "Refresf",
              ),
              PopupMenuItem(
                child: Text("Help"),
                value: "Help",
              ),
            ];
          })
        ],
      ),
      body: ListView.builder(
          itemCount: Constants.chatModels.length + 2,
          itemBuilder: (context, index) {
            if ((index < Constants.chatModels.length) && (Constants.chatModels[index].selected)) {
              Constants.chatModels[index].selected = false;
            }
            if (index == 0) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewGroupPage()));
                },
                child: CustomContactCard(
                    title: "New group", iconData: Icons.group_add),
              );
            } else if (index == 1) {
              return CustomContactCard(
                  title: "New contact", iconData: Icons.person_add);
            } else {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndividualChatPage(
                                chatModel: Constants.chatModels[index - 2])));
                  },
                  child: ContactCard(Constants.chatModels[index - 2]));
            }
          }),
    );
  }
}
