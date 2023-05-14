import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:hw_quizapp/data/db-provider.dart';
import 'package:hw_quizapp/screens/add-screen.dart';
import 'package:hw_quizapp/screens/main-page.dart';
import 'package:hw_quizapp/widgets/answer-widget.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              navigateTo(context, MyHomePage());
            },
          ),
          title: const Text('Create Quiz'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15),
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    navigateTo(context, AddScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 13),
                      Text(
                        'Add new question',
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: provider.modelList.length,
                    itemBuilder: (context, index) {
                      return provider.modelList.length == 0
                          ? SizedBox()
                          : QuestionWidget(provider.modelList[index], context);
                    }),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    });
  }

  Widget QuestionWidget(Model model, BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.1)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  model.queName.toString(),
                  style: TextStyle(fontSize: 17),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Delete question'),
                            content: Text(
                              'Are you sure yoy want to delete this question?',
                              style: TextStyle(fontSize: 17),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Provider.of<DbProvider>(context,
                                          listen: false)
                                      .deleteTask(model);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    content: Text('Question deleted'),
                                  ));
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.teal, fontSize: 17),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ContainerWidget(model.ansA.toString(), Colors.white, '1', model),
            ContainerWidget(model.ansB.toString(), Colors.white, '2', model),
            ContainerWidget(model.ansC.toString(), Colors.white, '3', model),
            ContainerWidget(model.ansD.toString(), Colors.white, '4', model),
          ],
        ));
  }

  Widget ContainerWidget(
      String text, Color color, String indexNum, Model model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: model.correctAns == indexNum ? Colors.green : color,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              color:
                  model.correctAns == indexNum ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
