import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 40.0;
  double resultFontSize = 50.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equationFontSize = 50.0;
        resultFontSize = 40.0;
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equationFontSize = 50.0;
        resultFontSize = 40.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 40.0;
        resultFontSize = 50.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else if (result != "0" ) {
        equationFontSize = 50.0;
        resultFontSize = 40.0;
        equation = result + buttonText;
        result = "0";
      } else {
        equationFontSize = 50.0;
        resultFontSize = 40.0;
        if (equation == "0" || equation == "00") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.125 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(16.0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: const BorderSide(
                        color: Colors.black54,
                        width: 1,
                        style: BorderStyle.solid)))),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.indigoAccent),
                      buildButton("⌫", 1, Colors.blueAccent),
                      buildButton("÷", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.indigo),
                      buildButton("8", 1, Colors.indigo),
                      buildButton("9", 1, Colors.indigo),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.indigo),
                      buildButton("5", 1, Colors.indigo),
                      buildButton("6", 1, Colors.indigo),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.indigo),
                      buildButton("2", 1, Colors.indigo),
                      buildButton("3", 1, Colors.indigo),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.indigo),
                      buildButton("0", 1, Colors.indigo),
                      buildButton("00", 1, Colors.indigo),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.blueAccent),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.indigoAccent),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
