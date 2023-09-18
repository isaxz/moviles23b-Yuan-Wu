import 'package:fraction_and_arithmetic_exp/arithmetic_expression_parser.dart';

// Example
void main() {
  String expression = "([63/3])*3+1";
  num result = evaluateMathExpression(expression);
  print("Result: $result");
}