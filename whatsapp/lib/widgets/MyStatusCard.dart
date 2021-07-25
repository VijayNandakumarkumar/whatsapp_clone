import 'package:flutter/material.dart';
import 'package:whatsapp/pages/CameraPage.dart';

class MyStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (builder) => CameraPage()));
      },
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 27,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/profile_pic1.png"),
            ),
            Positioned(
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.greenAccent[700],
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ))
          ],
        ),
        title: Text("My Status", style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text("Tap to add status",),
      ),
    );
  }
}
