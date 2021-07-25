import 'package:flutter/material.dart';
import 'package:whatsapp/pages/CameraPage.dart';
import 'package:whatsapp/widgets/MyStatusCard.dart';
import 'package:whatsapp/widgets/OthersStatusCard.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 55,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.blueGrey[100],
              elevation: 8,
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[700],
              ),
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder) => CameraPage()));
              },
              backgroundColor: Colors.greenAccent[700],
              elevation: 5,
              child: Icon(Icons.camera_alt))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyStatusCard(),
            SizedBox(height: 5,),
            CustomDivider("Recent updates", context),
            SizedBox(height: 10,),
            OthersStatusCard(name: "Vijay", time: "18:00", imageName: "profile_pic2", isSeen: false, noOfStatuses: 3),
            OthersStatusCard(name: "Kumar", time: "20:00", imageName: "profile_pic3", isSeen: false, noOfStatuses: 8),
            OthersStatusCard(name: "Rock", time: "19:00", imageName: "profile_pic1", isSeen: false, noOfStatuses: 5),
            OthersStatusCard(name: "HHH", time: "18:00", imageName: "profile_pic3", isSeen: false, noOfStatuses: 7),
            CustomDivider("Viewed updates", context),
            OthersStatusCard(name: "Dhoni", time: "18:00", imageName: "profile_pic2", isSeen: true, noOfStatuses: 2),
            OthersStatusCard(name: "Raina", time: "18:00", imageName: "profile_pic1", isSeen: true, noOfStatuses: 1),
            OthersStatusCard(name: "Ronaldo", time: "18:00", imageName: "profile_pic3", isSeen: true, noOfStatuses: 3),
          ],
        )
      ),
    );
  }
  Widget CustomDivider(final String text, final BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 5),
        child: Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.bold),),
      ),
    );
  }
}




