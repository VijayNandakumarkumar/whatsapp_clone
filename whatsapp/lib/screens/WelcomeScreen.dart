import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("Welcome to WhatsApp",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                    fontWeight: FontWeight.w500)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Image.asset(
              "assets/welcome_screen_bg.png",
              height: 230,
              width: 230,
              color: Colors.greenAccent[700],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey[500], fontSize: 15),
                      children: [
                        TextSpan(text: "Read our "),
                        TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.cyan[700])),
                        TextSpan(
                            text:
                                ". Tap on \"Agree and continue\" to accept our "),
                        TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: Colors.cyan[700]))
                      ])),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            InkWell(
              onTap: () {

              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width - 100,
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 8,
                  color: Colors.greenAccent[700],
                  child: Center(
                    child: Text("AGREE AND CONTINUE",
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text("from", style: TextStyle(color: Colors.grey[500]),),
            SizedBox(height: 5,),
            Text("FACEBOOK", style: TextStyle(color: Colors.greenAccent[400]))
          ],
        ),
      ),
    ));
  }
}
