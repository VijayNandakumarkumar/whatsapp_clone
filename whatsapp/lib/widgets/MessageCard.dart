import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String time;
  const MessageCard({this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Align(
          alignment: Alignment.centerRight,
          child: Card(
              margin: EdgeInsets.only(top: 10, bottom:10, right: 10, left: 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(0))),
              elevation: 1,
              color: Color(0xffdcf8c6),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, right: 50, bottom: 20),
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Row(
                      children: [
                        Text(
                          time,
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                        Icon(
                          Icons.done_all,
                          color: Colors.blue,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
