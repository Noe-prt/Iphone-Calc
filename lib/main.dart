
import 'package:flutter/material.dart';
import 'utils/button_calc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String outputText = "0";
  String calcStringToDisplay = "0";
  String calcString = "0";
  String lastChar = "";
  String result = "";
  List<String> operators = ["*", "/", "-", "+", "%"];
  String currentOperator = "";

  String resetButton = "AC";

  Color buttonDivideBackground = Color(0xffffFF9500);
  Color divideBackground = Colors.white;

  Color buttonAddBackground = Color(0xffffFF9500);
  Color addBackground = Colors.white;

  Color buttonSubtractBackground = Color(0xffffFF9500);
  Color subtractBackground = Colors.white;

  Color buttonMultiplyBackground = Color(0xffffFF9500);
  Color multiplyBackground = Colors.white;

  Color buttonEqualBackground = Color(0xffffFF9500);
  Color equalBackground = Colors.white;

  double fontSizeMultiplier = 1;

  void setOutputSize() {
    setState(() {
      if (outputText.length == 7)
      {
        fontSizeMultiplier = 0.7;
      }
      else if (outputText.length == 8)
      {
        fontSizeMultiplier = 0.6;
      }
      else if (outputText.length == 9)
      {
        fontSizeMultiplier = 0.5;
      }
      else {
        fontSizeMultiplier = 1;
      }
    });
  }

  void displayOutput(String buttonText) {
    setState(() {
      resetButton = "C";
      if (operators.contains(buttonText)) {
        if (operators.contains(lastChar) && buttonText == lastChar) return;
        calcString += buttonText;
        outputText = calcStringToDisplay;
        currentOperator = buttonText;
        switch (buttonText)
            {
          case "/":
            buttonDivideBackground = Colors.white;
            divideBackground = Color(0xffffFF9500);

            buttonAddBackground = Color(0xffffFF9500);
            addBackground = Colors.white;

            buttonMultiplyBackground = Color(0xffffFF9500);
            multiplyBackground = Colors.white;

            buttonSubtractBackground = Color(0xffffFF9500);
            subtractBackground = Colors.white;
            break;

          case "*":
            buttonMultiplyBackground = Colors.white;
            multiplyBackground = Color(0xffffFF9500);

            buttonAddBackground = Color(0xffffFF9500);
            addBackground = Colors.white;

            buttonDivideBackground = Color(0xffffFF9500);
            divideBackground = Colors.white;

            buttonSubtractBackground = Color(0xffffFF9500);
            subtractBackground = Colors.white;
            break;

          case "-":
            buttonSubtractBackground = Colors.white;
            subtractBackground = Color(0xffffFF9500);

            buttonAddBackground = Color(0xffffFF9500);
            addBackground = Colors.white;

            buttonDivideBackground = Color(0xffffFF9500);
            divideBackground = Colors.white;

            buttonMultiplyBackground = Color(0xffffFF9500);
            multiplyBackground = Colors.white;
            break;

          case "+":
            buttonAddBackground = Colors.white;
            addBackground = Color(0xffffFF9500);

            buttonDivideBackground = Color(0xffffFF9500);
            divideBackground = Colors.white;

            buttonMultiplyBackground = Color(0xffffFF9500);
            multiplyBackground = Colors.white;

            buttonSubtractBackground = Color(0xffffFF9500);
            subtractBackground = Colors.white;
            break;
        }
      } else if (operators.contains(lastChar)) {
        setOutputSize();
        calcString += buttonText;
        calcStringToDisplay = buttonText;
        outputText = calcStringToDisplay;
      } else if (calcString == "0") {
        calcStringToDisplay = buttonText;
        calcString = buttonText;
        outputText = buttonText;
      } else {
        setOutputSize();
        calcStringToDisplay += buttonText;
        calcString += buttonText;
        outputText = calcStringToDisplay;
      }
      lastChar = buttonText;
    });
  }

  void resetOutput() {
    setState(() {
      if (calcString.isEmpty) return;
      calcStringToDisplay = "0";
      calcString = "0";
      result = "";
      outputText = "0";
      resetButton = "AC";
      fontSizeMultiplier = 1;

      buttonAddBackground = Color(0xffffFF9500);
      addBackground = Colors.white;

      buttonDivideBackground = Color(0xffffFF9500);
      divideBackground = Colors.white;

      buttonMultiplyBackground = Color(0xffffFF9500);
      multiplyBackground = Colors.white;

      buttonSubtractBackground = Color(0xffffFF9500);
      subtractBackground = Colors.white;
    });
  }


  void displayResult() {
    setState(() {
      try {
        Parser p = Parser();
        Expression exp = p.parse(calcString);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);

        if (result % 1 == 0)
          {
            calcString = result.toInt().toString();
            calcStringToDisplay = result.toInt().toString();
            outputText = result.toInt().toString();
            result = 0;
          }
        else {
          calcString = result.toStringAsFixed(2);
          calcStringToDisplay = result.toStringAsFixed(2);
          outputText = result.toStringAsFixed(2);
          result = 0;
        }
        buttonAddBackground = Color(0xffffFF9500);
        addBackground = Colors.white;

        buttonDivideBackground = Color(0xffffFF9500);
        divideBackground = Colors.white;

        buttonMultiplyBackground = Color(0xffffFF9500);
        multiplyBackground = Colors.white;

        buttonSubtractBackground = Color(0xffffFF9500);
        subtractBackground = Colors.white;
        print(result);
      } catch (e) {
        outputText = "Error";
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.43,
              color: Colors.black,
              padding: EdgeInsets.only(right: 10.0, bottom: 5.0),
              child: Text(
                outputText,
                style: TextStyle(
                  fontSize: 100 * fontSizeMultiplier,
                  color: Colors.white,
                  fontFamily: 'Number',
                ),
              ),
              alignment: Alignment.bottomRight,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.57,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => resetOutput(),
                        child: CalcButton(
                          textColor: Colors.black,
                          buttonText: resetButton,
                          buttonColor: Color(0xffffD4D4D2).withOpacity(.8),
                          fontSize: 36.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("+/-"),
                        child: CalcButton(
                          textColor: Colors.black,
                          buttonText: "+/-",
                          buttonColor: Color(0xffffD4D4D2).withOpacity(.8),
                          fontSize: 24.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("%"),
                        child: CalcButton(
                          textColor: Colors.black,
                          buttonText: "%",
                          buttonColor: Color(0xffffD4D4D2).withOpacity(.8),
                          fontSize: 36.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("/"),
                        child: CalcButton(
                          textColor: divideBackground,
                          buttonText: "/",
                          buttonIcon: FontAwesomeIcons.divide,
                          buttonColor: buttonDivideBackground,
                          fontSize: 26.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => displayOutput("7"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "7",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("8"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "8",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("9"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "9",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("*"),
                        child: CalcButton(
                          textColor: multiplyBackground,
                          buttonText: "x",
                          buttonIcon: Icons.close_outlined,
                          buttonColor: buttonMultiplyBackground,
                          fontSize: 36.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => displayOutput("4"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "4",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("5"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "5",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("6"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "6",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("-"),
                        child: CalcButton(
                          textColor: subtractBackground,
                          buttonText: "-",
                          buttonColor: buttonSubtractBackground,
                          fontSize: 56.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => displayOutput("1"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "1",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("2"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "2",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("3"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "3",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("+"),
                        child: CalcButton(
                          textColor: addBackground,
                          buttonText: "+",
                          buttonColor: buttonAddBackground,
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => displayOutput("0"),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: "0",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 36.0,
                          buttonHeight: 80,
                          buttonWidth: 175,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayOutput("."),
                        child: CalcButton(
                          textColor: Colors.white,
                          buttonText: ".",
                          buttonColor: Color(0xffff1C1C1C),
                          fontSize: 52.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => displayResult(),
                        child: CalcButton(
                          textColor: equalBackground,
                          buttonText: "=",
                          buttonColor: buttonEqualBackground,
                          fontSize: 42.0,
                          buttonHeight: 80,
                          buttonWidth: 80,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
