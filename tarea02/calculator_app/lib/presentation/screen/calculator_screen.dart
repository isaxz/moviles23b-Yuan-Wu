import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calculator_app/fraction.dart';
import 'package:calculator_app/arithmetic_expression_parser.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

enum Operations {sum, sub, mult, div}

class _CalculatorScreenState extends State<CalculatorScreen> {

  String smallScreen = '';
  String bigScreen = '0';

  late Operations oper;
  bool operatorAsigned = false;

  Fraction? value1;
  Fraction? value2;
  num result= 0;
  String expression ='';

  void onPress(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          smallScreen = '';
          bigScreen = '0';
          expression = '';
          break;
        case 'backspace':
          if (bigScreen == '0') break;
          if (bigScreen.length == 1) {
            bigScreen = '0';
          } else {
            bigScreen = bigScreen.substring(0, bigScreen.length - 1);
          }
          break;
        case '+':
          operatorAsigned = true;
          oper = Operations.sum;
          expression = '$expression$bigScreen+';
          smallScreen = expression;
          break;
        case '-':
          operatorAsigned = true;
          oper = Operations.sub;
          expression = '$expression$bigScreen-';
          smallScreen = expression;
          break;
        case '*':
          operatorAsigned = true;
          oper = Operations.mult;
          expression = '$expression$bigScreen*';
          smallScreen = expression;
          break;
        case '/':
          operatorAsigned = true;
          oper = Operations.div;
          expression = '$expression$bigScreen/';
          smallScreen = expression;
          break;
        case '^':
          operatorAsigned = true;
          expression = '$expression$bigScreen^';
          smallScreen = expression;
          break;
        case '=':
          expression += bigScreen;
          smallScreen = '$smallScreen$bigScreen=';
          if (expression.isNotEmpty) {
            result = evaluateMathExpression(expression);
            print('expression: $expression  result: $result');
          }
          bigScreen = result.toString();
          expression='';
          operatorAsigned = true;
          break;
        default:
          if(operatorAsigned) {
            bigScreen = '0';
            operatorAsigned = false;
          }
          if (bigScreen == '0') {
            bigScreen = text;
          } else {
            bigScreen = bigScreen + text;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.black,
            height: 40,
            width: double.infinity,
            child: Text(smallScreen,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
                fontFamily: 'DelaGothic',
                fontFeatures: [
                  FontFeature.fractions(),
                ]
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.black,
            height: 100,
            width: double.infinity,
            child: Text(bigScreen,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 70,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "AC",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("AC"),
                    ),
                    CalculatorBtn(
                      icon: Icons.backspace_rounded,
                      backgroundColor: Colors.white38,
                      onPressed: () => onPress("backspace"),
                    ),
                    CalculatorBtn(
                      text: "]",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("]"),
                    ),
                    CalculatorBtn(
                      text: "^",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("^"),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "(",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("("),
                    ),
                    CalculatorBtn(
                      text: ")",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress(")"),
                    ),
                    CalculatorBtn(
                      text: "[",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("["),
                    ),
                    CalculatorBtn(
                      text: "/",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("/"),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "7",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("7"),
                    ),
                    CalculatorBtn(
                      text: "8",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("8"),
                    ),
                    CalculatorBtn(
                      text: "9",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("9"),
                    ),
                    CalculatorBtn(
                      text: "*",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("*"),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "4",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("4"),
                    ),
                    CalculatorBtn(
                      text: "5",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("5"),
                    ),
                    CalculatorBtn(
                      text: "6",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("6"),
                    ),
                    CalculatorBtn(
                      text: "-",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("-"),
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "1",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("1"),
                    ),
                    CalculatorBtn(
                      text: "2",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("2"),
                    ),
                    CalculatorBtn(
                      text: "3",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("3"),
                    ),
                    CalculatorBtn(
                      text: "+",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("+"),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "+/-",
                      backgroundColor: Colors.white12,
                    ),
                    CalculatorBtn(
                      text: "0",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("0"),
                    ),
                    CalculatorBtn(
                      text: ".",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("."),
                    ),
                    CalculatorBtn(
                      text: "=",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("="),
                    ),
                  ],
                ),
              ]
            ),
          ),
        ],
      )
    );
  }
}

class CalculatorBtn extends StatelessWidget {

  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CalculatorBtn({
    this.icon,
    this.text='',
    required this.backgroundColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 20,
      child: Container(
        height: 80,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: (icon != null)
        ? Icon(icon, size: 35, color: Colors.white)
        : Text(text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}