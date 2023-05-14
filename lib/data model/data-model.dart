import 'package:hw_quizapp/data/db-helper.dart';

class Model {
  int? id;
  String? queName;
  String? ansA;
  String? ansB;
  String? ansC;
  String? ansD;
  String? correctAns;

  Model({
    required this.queName,
    required this.ansA,
    required this.ansB,
    required this.ansC,
    required this.ansD,
    required this.correctAns,
  });
  Model.fromMap(Map<String, dynamic> map) {
    id = map[DbHelper.quesIdColumName];
    queName = map[DbHelper.questionColumName];
    ansA = map[DbHelper.answAColumName];
    ansB = map[DbHelper.answBColumName];
    ansC = map[DbHelper.answCColumName];
    ansD = map[DbHelper.answDColumName];
    correctAns = map[DbHelper.corrAnswColumName];
  }
  Map<String, dynamic> toMap() {
    return {
      DbHelper.quesIdColumName: id,
      DbHelper.questionColumName: queName,
      DbHelper.answAColumName: ansA,
      DbHelper.answBColumName: ansB,
      DbHelper.answCColumName: ansC,
      DbHelper.answDColumName: ansD,
      DbHelper.corrAnswColumName: correctAns,
    };
  }
}
