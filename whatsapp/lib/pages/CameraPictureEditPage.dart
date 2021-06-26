import 'package:flutter/material.dart';
import 'dart:io';

class CameraPictureEditPage extends StatelessWidget {
  final String path;

  const CameraPictureEditPage({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.crop_rotate,
                color: Colors.white,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.white,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.title,
                color: Colors.white,
                size: 27,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 27,
              )),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 170,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: TextFormField(
                  // textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.add_photo_alternate,
                        size: 27,
                        color: Colors.white,
                      ),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.teal[700],
                        child: Icon(Icons.check, color: Colors.white, size: 27),
                      ),
                      border: InputBorder.none,
                      hintText: "Add Caption...",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
