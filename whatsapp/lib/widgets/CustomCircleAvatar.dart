import 'package:flutter/material.dart';
import 'package:whatsapp/model/ChatModel.dart';

class CustomCircleAvatar extends StatelessWidget {
  final String name;

  const CustomCircleAvatar({this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
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
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2,
          ),
          // Container(
          //   width: 45,
          Text(
            name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          // ),
        ],
      ),
    );
  }
/*
   Container(
      color: Colors.blue,
      height: 10,
      width: 50,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 23,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueGrey,
              ),
              Text(
                "name",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Positioned(
            top: 7,
            right: 2,
            child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 15,
                )),
          )
        ],
      ),
    );
  * */
}
