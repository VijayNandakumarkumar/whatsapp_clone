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
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  child: Icon(
                      widget.chatModel.isGroup ? Icons.group : Icons.person,
                      color: Colors.white),
                  backgroundColor: Colors.grey,
                  radius: 20,
                ),
              )
            ],
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatModel.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "last seen today at " + widget.chatModel.time,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {},
          ),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("View contact"),
                  value: "View contact",
                ),
                PopupMenuItem(
                  child: Text("Media, links, and docs"),
                  value: "Media, links, and docs",
                ),
                PopupMenuItem(
                  child: Text("WhatsApp web"),
                  value: "WhatsApp web",
                ),
                PopupMenuItem(
                  child: Text("Search"),
                  value: "Search",
                ),
                PopupMenuItem(
                  child: Text("Mute notifications"),
                  value: "Mute notifications",
                ),
                PopupMenuItem(
                  child: Text("Wallpaper"),
                  value: "Wallpaper",
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: EdgeInsets.only(right: 2, left: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon:
                                IconButton(icon: Icon(Icons.emoji_emotions)),
                            hintText: "Type a message",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(icon: Icon(Icons.attach_file)),
                                IconButton(
                                    icon: Icon(
                                  Icons.camera_alt,
                                ))
                              ],
                            ),
                            contentPadding: EdgeInsets.all(5)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, right: 2, left: 2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.green,
                      child: IconButton(icon: Icon(Icons.mic, color: Colors.white,), onPressed: () {},),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
