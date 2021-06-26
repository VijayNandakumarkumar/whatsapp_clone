import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/pages/CreateGroupPage.dart';
import 'package:whatsapp/pages/CreateNewGroup.dart';
import 'package:whatsapp/pages/IndividualChatPage.dart';
import 'package:whatsapp/widgets/ContactCard.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/widgets/CustomCircleAvatar.dart';

class NewGroupPage extends StatefulWidget {
  @override
  _NewGroupPageState createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  List<ChatModel> group = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
          title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New group",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Add participants",
                  overflow: TextOverflow.ellipsis,
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
          ]),
      body: WillPopScope(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              ListView.builder(
                  itemCount: Constants.chatModels.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return (group.length > 0)
                          ? Container(
                              height: 90,
                            )
                          : Container(
                              height: 20,
                            );
                    } else {
                      return Constants.chatModels[index-1].isGroup ? Container() : InkWell(
                          onTap: () {
                            if (Constants.chatModels[index - 1].selected) {
                              setState(() {
                                Constants.chatModels[index - 1].selected = false;
                                group.remove(Constants.chatModels[index - 1]);
                                print(group);
                              });
                            } else {
                              setState(() {
                                Constants.chatModels[index - 1].selected = true;
                                group.add(Constants.chatModels[index - 1]);
                              });
                            }
                          },
                          child: Column(
                            children: [
                              ContactCard(Constants.chatModels[index - 1]),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 80.0, right: 20),
                                child: Divider(
                                  thickness: 1,
                                ),
                              )
                            ],
                          ));
                    }
                  }),
              (group.length > 0)
                  ? Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Constants.chatModels.length,
                              itemBuilder: (context, index) {
                                if (Constants.chatModels[index].selected) {
                                  return InkWell(
                                      onTap: () {
                                        setState(() {
                                          group.remove(
                                              Constants.chatModels[index]);
                                          Constants.chatModels[index].selected =
                                              false;
                                        });
                                      },
                                      child: CustomCircleAvatar(
                                          name:
                                              Constants.chatModels[index].name));
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                        Divider(
                          thickness: 1,
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        onWillPop: () {
          setState(() {
            for(ChatModel chatModel in group) {
              chatModel.selected = false;
            }
            group = [];
          });
          Navigator.pop(context);
          return Future.value(false);
        },
      ),
      floatingActionButton: (group.length > 0)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            CreateNewGroup(chatModels: group)));
              },
              child: Icon(Icons.arrow_forward_rounded),
            )
          : Container(),
    );
  }
}
