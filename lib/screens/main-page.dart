import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:hw_quizapp/data/db-provider.dart';
import 'package:hw_quizapp/screens/question-screen.dart';
import 'package:hw_quizapp/screens/quiz-screen.dart';
import 'package:hw_quizapp/widgets/answer-widget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  String content = "";
  String content2 = "";
  @override
  Widget build(BuildContext context) {
    List<Model> modelList = Provider.of<DbProvider>(context).modelList;
    return Consumer<DbProvider>(
      builder: (context, provider, x) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
              child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal),
                accountName: Text("Laila anouar Abu Salah",
                    style: TextStyle(fontSize: 15)),
                accountEmail: Text("lailaanouar1808@gmail.com",
                    style: TextStyle(fontSize: 15)),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    "L",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  backgroundColor: Colors.pink,
                ),
              ),
              ListTile(
                leading: Icon(Icons.create),
                title: InkWell(
                    onTap: () {
                      navigateTo(context, QuestionScreen());
                    },
                    child: Text(
                      "Create Quiz",
                      style: TextStyle(fontSize: 17),
                    )),
              ),
              ListTile(
                leading: Icon(Icons.quiz),
                title: InkWell(
                    onTap: () {
                      navigateTo(context, QuizScreen());
                    },
                    child: Text("Start Quiz", style: TextStyle(fontSize: 17))),
              ),
              Divider(
                height: 0.7,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: InkWell(
                    onTap:(){
                      SystemNavigator.pop();
                    },child: Text("Exit", style: TextStyle(fontSize: 17))),
              ),
            ],
          )),
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text('Quiz App'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/quiz.png',
                  width: 300,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 240,
                  child: ElevatedButton(
                    onPressed: () {
                      navigateTo(context, QuizScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Let\'s Start!',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
