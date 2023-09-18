import 'package:test/test.dart';
import 'package:fraction_and_arithmetic_exp/fraction.dart';
import 'package:fraction_and_arithmetic_exp/arithmetic_expression_parser.dart'; // Reemplaza 'tu_paquete' y 'your_package' con las rutas correctas

void main() {
  group('TreeNode Tests', () {
    test('Pre-order traversal should return correct result', () {
      // create a test tree
      var root = TreeNode('+');
      var left = TreeNode('5');
      var right = TreeNode('*');
      var rightLeft = TreeNode('3');
      var rightRight = TreeNode('2');

      root.left = left;
      root.right = right;
      right.left = rightLeft;
      right.right = rightRight;

      // Realiza la prueba de recorrido en preorden
      expect(root.preOrderTraversal(), '+5*32');
    });
  });

  group('Expression Evaluation Tests', () {
    test('Evaluate addition expression', () {
      expect(evaluateMathExpression('2+3'), equals(5));
    });

    test('Evaluate subtraction expression', () {
      expect(evaluateMathExpression('5-2'), equals(3));
    });

    test('Evaluate multiplication expression', () {
      expect(evaluateMathExpression('4*3'), equals(12));
    });

    test('Evaluate division expression', () {
      expect(evaluateMathExpression('8/4'), equals(2));
    });

    test('Evaluate expression with parentheses', () {
      expect(evaluateMathExpression('(2+3)*4'), equals(20));
    });

    test('Evaluate complex expression', () {
      expect(evaluateMathExpression('2+3*4-6/2'), equals(11));
    });

    test('Evaluate expression with fractions', () {
      expect(
        evaluateMathExpressionReturnFraction('[1/2]+[1/4]'),
        equals(Fraction(3, 4)),
      );
    });

    test('Evaluate expression with invalid division by zero', () {
      expect(
        () => evaluateMathExpression('1/0'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Expression Tokenization Tests', () {
    test('Tokenize simple expression', () {
      expect(createExpressionTokens('2+3'), equals(['2', '+', '3']));
    });

    test('Tokenize expression with fractions', () {
      expect(createExpressionTokens('[1/2]+[3/4]'), equals(['[1/2]', '+', '[3/4]']));
    });

    // Agrega más pruebas de tokenización según sea necesario
  });

  group('RPN Conversion Tests', () {
    test('Convert infix to RPN notation', () {
      expect(orderByPrecedence(['2', '+', '3']), equals(['2', '3', '+']));
    });

    test('Convert complex infix to RPN notation', () {
      expect(
        orderByPrecedence(['2', '+', '3', '*', '4', '-', '6', '/', '2']),
        equals(['2', '3', '4', '*', '+', '6', '2', '/', '-']),
      );
    });
  });
}
