import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Calculator',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Danh Phan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String top_display = '';
  String bot_display = '';
  String userInput = '';
  String result = '';
  int sizeInput = 0;
  bool doneCalc = false;

  buttonPressed(String buttonText) {
    if (buttonText == "CE") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, sizeInput);
        userInput += '0';
        setState(() {
          bot_display = '';
        });
      }
    } else if (buttonText == "C") {
      clearAll();
    } else if (buttonText == "DEL") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        setState(() {
          bot_display = userInput;
        });
      }
    } else if (buttonText == "=") {
      calcResult();
      userInput = result;
      doneCalc = true;
    } else {
      if (doneCalc) {
        clearAll();
        doneCalc = false;
      }
      userInput += buttonText;
      if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "x" ||
          buttonText == "÷" ||
          buttonText == "%") {
        sizeInput = userInput.length;
        setState(() {
          top_display = userInput;
          bot_display = '';
        });
      } else
        setState(() {
          bot_display += buttonText;
        });
    }
  }

  void calcResult() {
    try {
      Parser p = Parser();
      Expression exp =
          p.parse(userInput.replaceAll('x', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toStringAsFixed(3);
      setState(() {
        top_display = userInput;
        bot_display = result;
      });
    } catch (e) {
      result = "Error";
    }
  }

  void clearAll() {
    userInput = '';
    result = '';
    setState(() {
      top_display = '';
      bot_display = '';
    });
  }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new OutlineButton(
        padding: new EdgeInsets.all(30.0),
        child: new Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: new Text(top_display,
                    style: new TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal,
                    ))),
            new Container(
                alignment: Alignment.centerRight,
                padding:
                    new EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: new Text(bot_display,
                    style: new TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ))),
            Padding(padding: EdgeInsets.only(top: 230)),
            new Column(children: [
              new Row(children: [
                buildButton("CE"),
                buildButton("C"),
                buildButton("DEL"),
                buildButton("÷")
              ]),
              new Row(children: [
                buildButton("7"),
                buildButton("8"),
                buildButton("9"),
                buildButton("x")
              ]),
              new Row(children: [
                buildButton("4"),
                buildButton("5"),
                buildButton("6"),
                buildButton("-")
              ]),
              new Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("+")
              ]),
              new Row(children: [
                buildButton("%"),
                buildButton("0"),
                buildButton("."),
                buildButton("=")
              ]),
            ])
          ],
        )));
  }
}
