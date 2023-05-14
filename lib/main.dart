import 'package:flutter/material.dart';
import 'package:hw_quizapp/screens/add-screen.dart';
import 'package:hw_quizapp/screens/main-page.dart';
import 'package:hw_quizapp/data/db-helper.dart';
import 'package:hw_quizapp/data/db-provider.dart';
import 'package:hw_quizapp/screens/question-screen.dart';
import 'package:hw_quizapp/screens/score-screen.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DbProvider>(
          create: (context) {
            return DbProvider();
          },),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home:  MyHomePage()
      )
    );
  }
}


