import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw_quizapp/screens/main-page.dart';
import 'package:hw_quizapp/widgets/answer-widget.dart';

class ScoreScreen extends StatelessWidget {
  int? score;
  int? numOfQue;
  String? image;
  String? message1;
  String? message2;
  ScoreScreen(
      {required this.score,
      required this.numOfQue,
      required this.image,
      required this.message1,
      required this.message2});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateTo(context, MyHomePage());
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.teal,
        title: Text(
          'Quiz App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message1.toString(),
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              image.toString(),
              width: 250,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Your Score : ' + score.toString() + '/' + numOfQue.toString(),
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 27),
            ),
            Text(
              message2.toString(),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  navigateTo(context, MyHomePage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Back to home',
                  style: TextStyle(fontSize: 21),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
