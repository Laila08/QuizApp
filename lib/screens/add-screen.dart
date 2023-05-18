import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:hw_quizapp/data/db-provider.dart';
import 'package:hw_quizapp/screens/question-screen.dart';
import 'package:hw_quizapp/widgets/answer-widget.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController controllerQuestion = TextEditingController();
  TextEditingController controllerAnswerA = TextEditingController();
  TextEditingController controllerAnswerB = TextEditingController();
  TextEditingController controllerAnswerC = TextEditingController();
  TextEditingController controllerAnswerD = TextEditingController();
  TextEditingController controllerCorrAnswer = TextEditingController();
  GlobalKey<FormState> addKey = GlobalKey();

  String? requiredValidator(String v) {
    if (v.length == 0) {
      return 'this field is required';
    }
  }

  @override
  Widget build(BuildContext context) {
    String? _selectedItem;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateTo(context, QuestionScreen());
          },
        ),
        title: Text('Add new question'),
        centerTitle: true,
      ),
      //end appbar section

      // start body section
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: addKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    focusNode:Provider.of<DbProvider>(context).focusNode,
                    controller: controllerQuestion,
                    validator: (String? v) {
                      if (v!.length == 0) {
                        return 'this field is required';
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.question_mark,
                        color:Provider.of<DbProvider>(context).isFocused?Colors.teal:Colors.grey ,
                      ),

                      prefixIconColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      labelStyle: TextStyle(color: Colors.black54),
                      labelText: 'Question',
                      hintText: 'Enter the question',
                    ),
                  ),
                ),
                AnswerWidget(
                    hintText: 'First Answer',
                    controller: controllerAnswerA,
                    ansChar: "A",
                    validator: requiredValidator,
                    color: Colors.amber),
                AnswerWidget(
                    hintText: 'Second Answer',
                    controller: controllerAnswerB,
                    ansChar: "B",
                    validator: requiredValidator,
                    color: Colors.green),
                AnswerWidget(
                    hintText: 'Third Answer',
                    controller: controllerAnswerC,
                    ansChar: "C",
                    validator: requiredValidator,
                    color: Colors.grey),
                AnswerWidget(
                    hintText: 'Fourth Answer',
                    controller: controllerAnswerD,
                    ansChar: "D",
                    validator: requiredValidator,
                    color: Colors.pink),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Text(
                      'Select the correct answer',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 120,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 5.0,
                                color: Colors.grey), // set the desired width
                          ),
                        ),
                        validator: (String? v) {
                          if (v!.length == 0) {
                            return 'this field is required';
                          }
                        },
                        onChanged: (String? value) {
                          setState(() {
                            _selectedItem = value;
                            controllerCorrAnswer.text = value ?? 'A';
                          });
                          print(_selectedItem);
                        },
                        value: _selectedItem ?? 'A',
                        items: [
                          DropdownMenuItem<String>(
                            value: 'A',
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'B',
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'B',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'C',
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'C',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'D',
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'D',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: Colors.teal,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () async {
                      if (addKey.currentState!.validate()) {
                        Model model = Model(
                            queName: controllerQuestion.text,
                            ansA: controllerAnswerA.text,
                            ansB: controllerAnswerB.text,
                            ansC: controllerAnswerC.text,
                            ansD: controllerAnswerD.text,
                            correctAns: controllerCorrAnswer.text == 'D'
                                ? '4'
                                : (controllerCorrAnswer.text == 'B'
                                    ? '2'
                                    : (controllerCorrAnswer.text == 'C'
                                        ? '3'
                                        : '1')));
                        await Provider.of<DbProvider>(context, listen: false)
                            .createNewQues(model);
                        print('*******');
                        print(model.correctAns);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Add question',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
