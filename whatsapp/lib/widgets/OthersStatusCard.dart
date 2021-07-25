import 'dart:math';

import 'package:flutter/material.dart';

class OthersStatusCard extends StatelessWidget {
  final String name;
  final String time;
  final String imageName;
  final bool isSeen;
  final int noOfStatuses;

  const OthersStatusCard({this.name, this.time, this.imageName, this.isSeen, this.noOfStatuses});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusCirclePainter(isSeen: this.isSeen, noOfStatuses: this.noOfStatuses),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/$imageName.png"),
        ),
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
      subtitle: Text("Today, $time", style: TextStyle(fontSize: 14, color: Colors.grey[700]),),
    );
  }
}

double getAngleFromDegree(double degree) {
  return degree * pi /180;
}

class StatusCirclePainter extends CustomPainter{
   final int noOfStatuses;
   final bool isSeen;

   StatusCirclePainter({this.noOfStatuses, this.isSeen});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint  = Paint()
        ..isAntiAlias = true
        ..strokeWidth = 6
        ..color = isSeen? Colors.grey : Color(0xff21bfa6)
        ..style = PaintingStyle.stroke;
    drawCircle(canvas, size, paint, noOfStatuses);
  }

  void drawCircle(final Canvas canvas, final Size size, final Paint paint, final int noOfStatuses) {
    if (noOfStatuses == 1)
      canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), getAngleFromDegree(0), getAngleFromDegree(360), false, paint);
    else {
      double degree = -90;
      double arc =  (360 / noOfStatuses);
      for ( int i = 0; i < noOfStatuses; i++) {
        canvas.drawArc(Rect.fromLTWH(0.0, 0.0, size.width, size.height), getAngleFromDegree(degree + 4), getAngleFromDegree(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}
