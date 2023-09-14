// import 'dart:html';
import 'package:calc/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var question = "";
  var answer = "0";
  var arr = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '-/+',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 33, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              //flex: 2,
              child: Column(
                //decoration: BoxDecoration(color: Colors.green.shade500),
                //color: Colors.grey,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      question,
                      style: TextStyle(fontSize: 30, color: Colors.black54),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 10),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      answer,
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  ),
                  /////
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.black38),
                //margin: const EdgeInsets.symmetric(vertical: 50),
                child: GridView.builder(
                  padding: EdgeInsets.all(13),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: arr.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Buttons(
                          buttonText: arr[index],
                          buttonTap: () {
                            question = "";
                            answer = '0';
                            setState(() {});
                          });
                    } else if (index == 1) {
                      return Buttons(
                          buttonText: arr[index],
                          buttonTap: () {
                            question =
                                question.substring(0, question.length - 1);
                            setState(() {});
                          });
                    } else if (index == arr.length - 1) {
                      return Buttons(
                        buttonText: arr[index],
                        buttonTap: () {
                          calculateAnswer();
                          setState(() {});
                        },
                      );
                    } else if (index == arr.length - 2) {
                      return Buttons(
                          buttonText: arr[index],
                          buttonTap: () {
                            if (question.startsWith('-')) {
                              question = question.substring(1);
                            } else {
                              String temp = "-";
                              temp = temp + question;
                              question = temp;
                            }
                            setState(() {});
                          });
                    } else {
                      return Buttons(
                        buttonText: arr[index],
                        buttonTap: () {
                          question += arr[index];
                          setState(() {});
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }

  void calculateAnswer() {
    //calculate the
    String temp = question;
    Parser p = Parser();
    Expression exp = p.parse(temp);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString(); // = 1.0
  }
}
