import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/model/ChatModel.dart';
import 'package:whatsapp/pages/IndividualChatPage.dart';
import 'package:whatsapp/widgets/EmojiPicker.dart';

class CreateNewGroup extends StatefulWidget {
  List<ChatModel> chatModels;

  CreateNewGroup({this.chatModels});

  @override
  _CreateNewGroupState createState() => _CreateNewGroupState();
}

class _CreateNewGroupState extends State<CreateNewGroup> {
  bool shouldShowEmojiPicker = false;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

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
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Add subject",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: WillPopScope(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: TextFormField(
                                focusNode: focusNode,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    hintText: "Type group subject... " +
                                        widget.chatModels.length.toString()),
                              )),
                              // TextFormField(
                              // )
                              IconButton(
                                icon: Icon(
                                  Icons.emoji_emotions_outlined,
                                  size: 23,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  focusNode.unfocus();
                                  focusNode.canRequestFocus = false;
                                  setState(() {
                                    shouldShowEmojiPicker =
                                        !shouldShowEmojiPicker;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Text(
                          "Provide a group subject and an optional group icon",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[300],
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10),
                            child: Text(
                              "Participants: " +
                                  widget.chatModels.length.toString(),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.lightGreenAccent[700],
                      child: IconButton(
                        icon: Icon(
                          Icons.done_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          final ChatModel newGroup = ChatModel(
                              "",
                              textEditingController.text,
                              "Hello, there mate",
                              "18:00",
                              true,
                              "status",
                            Constants.chatModels.length + 1,);
                          Constants.chatModels.insert(0, newGroup);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          for(ChatModel chatModel in Constants.chatModels) {
                            chatModel.selected = false;
                          }
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) {
                            return IndividualChatPage(chatModel: newGroup);
                          }));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: List.generate(widget.chatModels.length, (index) {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.blueGrey[200],
                            child: Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            width: 40,
                            child: Text(
                              widget.chatModels[index].name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          // ),
                        ],
                      );
                    }),
                  )),
            ),
            shouldShowEmojiPicker
                ? emojiPicker(textEditingController)
                : Container(),
          ]),
        ),
        onWillPop: () {
          if (shouldShowEmojiPicker) {
            setState(() {
              shouldShowEmojiPicker = false;
            });
          } else {
            AlertDialog(
              title: Text(
                "Hello",
              ),
            );
            setState(() {
              widget.chatModels = [];
            });
            Navigator.pop(context);
          }
          return Future.value(false);
        },
      ),
    );
  }
}
