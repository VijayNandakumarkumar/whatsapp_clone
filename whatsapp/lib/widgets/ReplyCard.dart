import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  final String message;
  const ReplyCard({this.message});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 65),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Card(
              margin: EdgeInsets.only(top: 10, bottom:10, left: 10, right: 45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(10))),
              elevation: 1,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 10.0, right: 60, bottom: 20),
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
                    right: 10,
                    child:
                        Text(
                          "20:00",
                          style:
                          TextStyle(fontSize: 13, color: Colors.grey[600]),
                        )
                  )
                ],
              )),
        ));
  }
}
