import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';

class IndividualChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const IndividualChatPage({Key key, this.chatModel}) : super(key: key);

  @override
  _IndividualChatPageState createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  bool shouldShowEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          shouldShowEmojiPicker = false;
        });
      }
    });
  }

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
        title: InkWell(
          onTap: () {},
          child: Column(
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
      body: WillPopScope(
        child: Stack(
          children: [
            ListView(),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 55,
                          child: Card(
                            margin:
                                EdgeInsets.only(right: 2, left: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              maxLines: 5,
                              minLines: 1,
                              controller: textEditingController,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                    icon: Icon(Icons.emoji_emotions),
                                    onPressed: () {
                                      // textEditingController.text = "podaPanni";
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      setState(() {
                                        shouldShowEmojiPicker =
                                            !shouldShowEmojiPicker;
                                      });
                                    },
                                  ),
                                  hintText: "Type a message",
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.attach_file),
                                        onPressed: () {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (builder) =>
                                                  attachmentModal());
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {},
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
                          padding: const EdgeInsets.only(
                              bottom: 8, right: 2, left: 2),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xFF075E54),
                            child: IconButton(
                              icon: Icon(
                                Icons.mic,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                    shouldShowEmojiPicker ? emojiPicker() : Container(),
                  ],
                ),
              ),
            )
          ],
        ),
        onWillPop: () {
          if (shouldShowEmojiPicker) {
            setState(() {
              shouldShowEmojiPicker = false;
            });
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }

  Widget attachmentModal() {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                attachmentIcon(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                SizedBox(
                  width: 40,
                ),
                attachmentIcon(Icons.camera_alt, Colors.pink, "Camera"),
                SizedBox(
                  width: 40,
                ),
                attachmentIcon(Icons.insert_photo, Colors.purple, "Gallery"),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                attachmentIcon(Icons.headset, Colors.orange, "Audio"),
                SizedBox(
                  width: 40,
                ),
                attachmentIcon(Icons.location_pin, Colors.teal, "Loaction"),
                SizedBox(
                  width: 40,
                ),
                attachmentIcon(Icons.person, Colors.blue, "Contact"),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget attachmentIcon(
      final IconData iconData, final Color color, final String iconName) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              iconData,
              size: 30,
              color: Colors.white,
            ),
            backgroundColor: color,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            iconName,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget emojiPicker() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          textEditingController.text = textEditingController.text + emoji.emoji;
        });
  }
}
