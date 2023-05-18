import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:hw_quizapp/data/db-provider.dart';
import 'package:hw_quizapp/screens/main-page.dart';
import 'package:hw_quizapp/screens/score-screen.dart';
import 'package:hw_quizapp/widgets/answer-widget.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController boardController = PageController(
    initialPage: 0,
  );
  bool isLast = false;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    List<Model> quesList = Provider.of<DbProvider>(context).modelList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Quiz App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: quesList.length < 5 || quesList.isEmpty
          ? buildSoerryItem()
          : Column(
              children: [
                Expanded(
                    child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: quesList.length,
                  onPageChanged: (int index) {
                    if (index == quesList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder: (context, index) => quesList.length == 0
                      ? CircularProgressIndicator()
                      : buildPageViewItem(
                          model: quesList[index],
                          index: index,
                          quesList: quesList),
                ))
              ],
            ),
    );
  }

  Widget buildPageViewItem(
      {required Model model, required int index, required List quesList}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question ',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Text(
                    '  /  ' + quesList.length.toString(),
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.teal),
              child: Text(
                model.queName.toString(),
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            buildAnswerItem(
                model: model, ansNum: 1, answer: model.ansA!, queList: quesList),
            buildAnswerItem(
                model: model, ansNum: 2, answer: model.ansB!, queList: quesList),
            buildAnswerItem(
                model: model, ansNum: 3, answer: model.ansC!, queList: quesList),
            buildAnswerItem(
                model: model, ansNum: 4, answer: model.ansD!, queList: quesList),
          ],
        ),
      ),
    );
  }

  Widget buildAnswerItem(
      {required Model model,
      required int ansNum,
      required String answer,
      required List queList}) {
    return InkWell(
      onTap: () {
        if (isLast) {
          if (ansNum.toString() == model.correctAns) {
            setState(() {
              score += 1;
            });
          }
          if ((score / queList.length) * 100 >= 75) {
            navigateTo(
                context,
                ScoreScreen(
                    score: score,
                    numOfQue: queList.length,
                    image: 'assets/result.jpg',
                    message1: 'Congratulations!',
                    message2: 'You\'re a superstar!'));
          } else if ((score / queList.length) * 100 >= 50) {
            navigateTo(
                context,
                ScoreScreen(
                    score: score,
                    numOfQue: queList.length,
                    image: 'assets/result.jpg',
                    message1: 'Congratulations!',
                    message2: 'Keep up the good work!'));
          } else {
            navigateTo(
                context,
                ScoreScreen(
                    score: score,
                    numOfQue: queList.length,
                    image: 'assets/fail.png',
                    message1: 'Oops!',
                    message2: 'Sorry,better luck next time!'));
          }

          print('score is');
          print(score);
        } else {
          if (ansNum.toString() == model.correctAns) {
            setState(() {
              score += 1;
            });
          }
          boardController.nextPage(
              duration: Duration(milliseconds: 750),
              curve: Curves.fastLinearToSlowEaseIn);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.teal,
          ),
        ),
        child: Text(
          answer.toString(),
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget buildSoerryItem() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sorry!',
            style: TextStyle(
                color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'You must add at least 5 questions to start',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/faq.png',
            width: 250,
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
    );
  }
}
