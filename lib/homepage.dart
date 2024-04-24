import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:taskone_calculator/mywidgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';
  List<String> _buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        // centerTitle: true,
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$userInput ",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$answer",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //user input and result
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: _buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (ctx, index) {
                // Clear Button
                if (index == 0) {
                  return MyButton(
                    color: Colors.green,
                    textColor: Colors.black,
                    buttonText: _buttons[index],
                    buttontapped: () {
                      setState(
                        () {
                          userInput = '';
                          answer = "0";
                        },
                      );
                    },
                  );
                }
                // +/- button
                else if (index == 1) {
                  return MyButton(
                    buttonText: _buttons[index],
                    color: Colors.green,
                    textColor: Colors.black,
                  );
                }
                //% Button
                else if (index == 2) {
                  return MyButton(
                    buttonText: _buttons[index],
                    color: Colors.green,
                    textColor: Colors.black,
                    buttontapped: () {
                      setState(() {
                        userInput += _buttons[index];
                        //userInput = userInput + buttons[index];
                      });
                    },
                  );
                }
                // Delete Button
                else if (index == 3) {
                  return MyButton(
                    color: Colors.green,
                    textColor: Colors.black,
                    buttonText: _buttons[index],
                    buttontapped: () {
                      setState(() {
                        userInput =
                            userInput.substring(0, userInput.length - 1);
                      });
                    },
                  );
                }
                // Equal_to Button
                else if (index == 18) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: _buttons[index],
                    color: Colors.orange[700],
                    textColor: Colors.white,
                  );
                }
                //  other buttons
                else {
                  return MyButton(
                    color:
                        isOperator(_buttons[index]) ? Colors.red : Colors.white,
                    textColor: isOperator(_buttons[index])
                        ? Colors.amber
                        : Colors.purple,
                    buttonText: _buttons[index],
                    buttontapped: () {
                      setState(() {
                        userInput += _buttons[index];
                      });
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

// function to calculate the input operation
  equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  //check if button is operators
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
}
