import 'package:flutter/material.dart';

void main() => runApp(MyApp());
// void/type funcName => "return value"

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Phan Công Danh - 19119160';

    return MaterialApp(
      title: "Sum of Two Numbers",
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: AddTwoNumbers(),
      ),
    );
  }
}

// *
class AddTwoNumbers extends StatefulWidget {
  @override
  _AddTwoNumbersState createState() => _AddTwoNumbersState();
}

class _AddTwoNumbersState extends State<AddTwoNumbers> {
  TextEditingController num1controller = new TextEditingController();
  TextEditingController num2controller = new TextEditingController();
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Sum of Two Numbers",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "  Number 1: ",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              new Flexible(
                child: new TextField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  controller: num1controller,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "  Number 2: ",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              new Flexible(
                child: new TextField(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.number,
                  controller: num2controller,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                onPressed: () {
                  setState(() {
                    if (num1controller.text != "" &&
                        num2controller.text != "") {
                      double sum = double.parse(num1controller.text) +
                          double.parse(num2controller.text);
                      result = sum.toString();
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: const Text("WARNING"),
                                content:
                                    const Text("Please enter two numbers."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.green,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                    }
                  });
                },
                //padding: EdgeInsets.all(5),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                " Result: ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
              Text(
                result,
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
