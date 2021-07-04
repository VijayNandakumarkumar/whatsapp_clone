import 'package:flutter/material.dart';
import 'package:whatsapp/Constants.dart';
import 'package:whatsapp/screens/HomeScreen.dart';
import 'package:whatsapp/widgets/CustomContactCard.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
      itemCount: Constants.chatModels.length,
      itemBuilder: (context, index) {
        if (!Constants.chatModels[index].isGroup) {
          return InkWell(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return HomeScreen(sourceId: Constants.chatModels[index].id,);
            }));
          },
          child: CustomContactCard(title: Constants.chatModels[index].name, iconData: Icons.person));
        } else {
          return Container();
        }
      }),
    );
  }
}
