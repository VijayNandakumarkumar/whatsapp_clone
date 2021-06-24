import 'package:flutter/material.dart';

class CustomContactCard extends StatelessWidget {
  final String title;
  final IconData iconData;

  const CustomContactCard({Key key, this.title, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          child: Icon(iconData, color: Colors.white, size: 30,),
          backgroundColor: Color(0xFF25D366),
        ),
        title: Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
