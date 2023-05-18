import 'package:flutter/material.dart';
import 'package:hw_quizapp/data%20model/data-model.dart';
import 'package:hw_quizapp/data/db-helper.dart';

class DbProvider extends ChangeNotifier {
  DbProvider() {
    selectAllData();
    focusNode = FocusNode();
    focusNode.addListener(_changeFocus);
  }
  List<Model> modelList = [];

  fillLists(List<Model> models) {
    modelList = models;
    notifyListeners();
  }

  addTaskToList(Model model) {
    modelList.add(model);
    fillLists(modelList);
  }

  createNewQues(Model model) async {
    await DbHelper.dbHelper.insertData(model);
    addTaskToList(model);
  }

  selectAllData() async {
    List<Model> queData = await DbHelper.dbHelper.selectData();
    fillLists(queData);
  }

  deleteTask(Model model) async {
    await DbHelper.dbHelper.deleteOneQuestion(model.id ?? 0);
    selectAllData();
    notifyListeners();
  }

  late FocusNode focusNode;
  bool isFocused = false;
  void _changeFocus(){
    isFocused = focusNode.hasFocus;
    notifyListeners();
  }
}
