import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';

class CreateGroupPage extends StatelessWidget {
  final List<ChatModel> chatModels;

  const CreateGroupPage({this.chatModels});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New group",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Add subject",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ]),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height - 580,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 50,
                              child: CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              child: TextFormField(
                                controller: textEditingController,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    hintText: "Type group subject...",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Icon(
                                Icons.emoji_emotions,
                                color: Colors.blueGrey,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.black,
                        child: Positioned(
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Text(
                              "Provide a group subject and optional group icon",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[300],
                      child: Column(
                        children: [
                          Positioned(
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, top: 5),
                              child: Text("Participant: " +
                                  chatModels.length.toString()),
                            ),
                          ),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: chatModels.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 23,
                                        child: Icon(
                                          Icons.person,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        chatModels[index].name,
                                        style: TextStyle(fontSize: 13,),
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
              Positioned(
                top: 80,
                right: 20,
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
