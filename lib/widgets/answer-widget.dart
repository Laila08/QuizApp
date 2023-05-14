import 'package:flutter/material.dart';
import 'package:hw_quizapp/widgets/text-field.dart';

Widget AnswerWidget(
    {required String ansChar,
    required TextEditingController controller,
    required String hintText,
    required Function validator,
    required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: color,
          child: Text(
            ansChar,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: TextFormFieldWidget(
                controller: controller, title: hintText, validator: validator)),
      ],
    ),
  );
}

void navigateTo(context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
