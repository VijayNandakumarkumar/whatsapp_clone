import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/model/MessageModel.dart';
import 'package:whatsapp/screens/CameraScreen.dart';
import 'package:whatsapp/widgets/EmojiPicker.dart';
import 'package:whatsapp/widgets/MessageCard.dart';
import 'package:whatsapp/widgets/ReplyCard.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChatPage extends StatefulWidget {
  final ChatModel chatModel;
  final int sourceId;

  const IndividualChatPage({Key key, this.chatModel, this.sourceId})
      : super(key: key);

  @override
  _IndividualChatPageState createState() => _IndividualChatPageState();
}

class _IndividualChatPageState extends State<IndividualChatPage> {
  bool shouldShowEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  IO.Socket socket;
  bool showSendButton = false;
  List<MessageModel> oldMessages;
  List<MessageModel> messages = [];
  ScrollController _scrollController = ScrollController();
  String chatMessageId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatMessageId = widget.sourceId.toString() + widget.chatModel.id.toString();
    print("chatMessageId " + chatMessageId);
    oldMessages = Constants.messageModels[chatMessageId];
    messages = oldMessages == null ? [] : oldMessages;
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          shouldShowEmojiPicker = false;
        });
      }
    });
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        // Offset passed by the parent
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void setMessage(final String message, final String source) {
    MessageModel messageModel = new MessageModel(
        source, message, DateTime.now().toString().substring(10, 16));
    setState(() {
      messages.add(messageModel);
    });
    print(messages.length);
  }

  void connect() {
    socket =
        IO.io("https://historic-arches-59532.herokuapp.com/", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnet": false,
    });
    print("Ello there mate");
    socket.connect();
    socket.emit("signin", widget.sourceId);
    socket.onConnect((data) {
      print("Connected");
      socket.on(
        "message",
        (data) {
          // print(data);
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut);
          setMessage(data, "destination");
        },
      );
    });
    print("Connected??" + socket.connected.toString());
  }

  void sendMessage(final String message, int sourceId, int targetId) {
    setMessage(message, "source");
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      new Image.asset(
        "assets/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WillPopScope(
            child: Column(
              children: [
                Expanded(
                  // height: MediaQuery.of(context).size.height - 145,
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return MessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      }),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      right: 2, left: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: TextFormField(
                                    maxLines: 5,
                                    minLines: 1,
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        setState(() {
                                          showSendButton = true;
                                        });
                                      } else {
                                        setState(() {
                                          showSendButton = false;
                                        });
                                      }
                                    },
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
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (builder) =>
                                                              CameraScreen()));
                                                },
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
                                      showSendButton ? Icons.send : Icons.mic,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      sendMessage(textEditingController.text,
                                          widget.sourceId, widget.chatModel.id);
                                      textEditingController.clear();
                                      setState(() {
                                        showSendButton = false;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          shouldShowEmojiPicker
                              ? emojiPicker(textEditingController)
                              : Container(),
                        ],
                      ),
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
                Constants.messageModels[chatMessageId] = messages;
                print("is message model empty after insersetions "+ Constants.messageModels.isEmpty.toString());
                Navigator.pop(context);
              }
              return Future.value(false);
            },
          ),
        ),
      ),
    ]);
  }

  Widget attachmentModal() {
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {},
                  child: attachmentIcon(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CameraScreen()));
                    },
                    child: attachmentIcon(
                        Icons.camera_alt, Colors.pink, "Camera")),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {},
                  child: attachmentIcon(
                      Icons.insert_photo, Colors.purple, "Gallery"),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {},
                  child: attachmentIcon(Icons.headset, Colors.orange, "Audio"),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {},
                  child: attachmentIcon(
                      Icons.location_pin, Colors.teal, "Loaction"),
                ),
                SizedBox(
                  width: 40,
                ),
                InkWell(
                  onTap: () {},
                  child: attachmentIcon(Icons.person, Colors.blue, "Contact"),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Widget attachmentIcon(
      final IconData iconData, final Color color, final String iconName) {
    return Column(
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
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
