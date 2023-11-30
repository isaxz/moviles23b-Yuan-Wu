import 'package:fraction_and_arithmetic_exp/fraction.dart';

class TreeNode {
  String value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);

  /// Perform a pre-order traversal of the tree.
  /// Returns a string representation of the traversal
  String preOrderTraversal() {
    String result = '';
    result += value; // Visit actual node
    result += ' ';
    
    if (left != null) {
      result+='L';
      result += left!.preOrderTraversal(); // Traverse the left subtree
    }

    if (right != null) {
      result+='R';
      result += right!.preOrderTraversal(); // Traverse the right subtree
    }

    return result;
  }
}

/// Tokenize a mathematical expression string.
/// Returns a list of tokens extracted from the input expression.
List<String> createExpressionTokens(String expression) {
  List<String> tokens = [];
  int currentIndex = 0;

  void addToken(String token) {
    tokens.add(token);
  }

  void processToken(String currentToken, bool inFraction) {
    if (currentToken.isNotEmpty) {
      addToken(currentToken);
    }
  }

  void recursiveTokenization(String currentToken, bool inFraction) {
    if (currentIndex == expression.length) {
      processToken(currentToken, inFraction);
      return;
    }

    String char = expression[currentIndex];
    currentIndex++;

    if (char == '[') {
      inFraction = true;
      currentToken += char;
    } else if (char == ']') {
      inFraction = false;
      currentToken += char;
      processToken(currentToken, inFraction);
      currentToken = '';
    } else if ((isOperator(char) || char == '(' || char == ')') && !inFraction) {
      processToken(currentToken, inFraction);
      currentToken = '';
      addToken(char);
    } else {
      if (inFraction) {
        currentToken += char;
      } else {
        currentToken += char;
        if (currentIndex < expression.length && isOperator(expression[currentIndex])) {
          processToken(currentToken, inFraction);
          currentToken = '';
        }
      }
    }

    recursiveTokenization(currentToken, inFraction);
  }

  recursiveTokenization('', false);

  return tokens;
}

/// Order tokens by operator precedence using the Shunting Yard algorithm.
/// Returns a list of tokens in Reverse Polish Notation (RPN).
List<String> orderByPrecedence(List<String> tokens) {
  List<String> output = [];
  List<String> operatorStack = [];
  int currentIndex = 0;

  void addToken(String token) {
    output.add(token);
  }

  void processOperators(int minPrecedence) {
    while (operatorStack.isNotEmpty) {
      String topOperator = operatorStack.last;
      if (isOperator(topOperator) && getPrecedence(topOperator) >= minPrecedence) {
        addToken(operatorStack.removeLast());
      } else {
        break;
      }
    }
  }

  void recursiveOrdering() {
    if (currentIndex == tokens.length) {
      processOperators(0);
      return;
    }

    String token = tokens[currentIndex];
    currentIndex++;

    if (!isOperator(token) && token != '(' && token != ')') {
      addToken(token);
    } else if (isOperator(token)) {
      int tokenPrecedence = getPrecedence(token);
      processOperators(tokenPrecedence);
      operatorStack.add(token);
    } else if (token == '(') {
      operatorStack.add(token);
    } else if (token == ')') {
      processOperators(0);
      if (operatorStack.isNotEmpty && operatorStack.last == '(') {
        operatorStack.removeLast();
      } else {
        throw ArgumentError("Invalid parenthesis format");
      }
    }

    recursiveOrdering();
  }

  recursiveOrdering();

  return output;
}

/// Build an expression tree from a list of RPN tokens.
TreeNode buildExpressionTree(List<String> rpnTokens) {
  List<TreeNode> stack = [];
  for (String token in rpnTokens) {
    if (!isOperator(token)) {
      if (token.startsWith('[') && token.endsWith(']')) {
        stack.add(TreeNode(token));
      } else {
        stack.add(TreeNode(token));
      }
    } else {
      TreeNode right = stack.removeLast();
      TreeNode left = stack.removeLast();
      TreeNode newNode = TreeNode(token);
      newNode.left = left;
      newNode.right = right;
      stack.add(newNode);
    }
  }

  if (stack.length != 1) {
    throw ArgumentError("Invalid expression");
  }

  return stack.first;
}

/// Check if a token is an operator.
bool isOperator(String token) {
  return token == '+' || token == '-' || token == '*' || token == '/';
}

/// Get the precedence of an operator.
int getPrecedence(String operator) {
  switch (operator) {
    case '+':
    case '-':
      return 1;
    case '*':
    case '/':
      return 2;
    default:
      return 0;
  }
}

/// Evaluate an arithmetic expression represented by a tree of TreeNode objects.
Fraction evaluateExpression(TreeNode? node) {
  if (node == null) {
    throw ArgumentError("Invalid expression");
  }

  if (node.left == null && node.right == null) {
    String value = node.value;
    late Fraction fraction;
    // Check if the value is a fraction in square brackets
    if (value.startsWith('[') && value.endsWith(']')) {
      value = value.substring(1, value.length - 1);
    }
    try{
      fraction = Fraction.fromString(value);
      return fraction;
    } catch (e) {
      throw Exception(e);
    }
  }

  Fraction leftValue = evaluateExpression(node.left);
  Fraction rightValue = evaluateExpression(node.right);

  switch (node.value) {
    case "+":
      return leftValue + rightValue;
    case "-":
      return leftValue - rightValue;
    case "*":
      return leftValue * rightValue;
    case "/":
      if (rightValue.denominator == 0) {
        throw ArgumentError("Division by zero");
      }
      return leftValue / rightValue;
    default:
      throw ArgumentError("Invalid operator: ${node.value}");
  }
}

/// Evaluate a mathematical expression and return the result as a num.
num evaluateMathExpression(String expression) {
  List<String> tokens = createExpressionTokens(expression);
  print("tokens: $tokens");
  List<String> rpnTokens = orderByPrecedence(tokens);
  print("tokens: $rpnTokens");
  TreeNode root = buildExpressionTree(rpnTokens);
  print('root: ${root.value}');
  print('preorder: ${root.preOrderTraversal()}');
  return evaluateExpression(root).toNum();
}

Fraction evaluateMathExpressionReturnFraction(String expression) {
  List<String> tokens = createExpressionTokens(expression);
  List<String> rpnTokens = orderByPrecedence(tokens);
  TreeNode root = buildExpressionTree(rpnTokens);
  return evaluateExpression(root);
}

/// Perform a pre-order traversal of a mathematical expression and return the result as a string.
/// This function tokenizes the input expression, converts it to RPN, builds an expression tree, and then performs the traversal.
String showPreOrderTrasversal(String expression) {
  List<String> tokens = createExpressionTokens(expression);
  List<String> rpnTokens = orderByPrecedence(tokens);
  TreeNode root = buildExpressionTree(rpnTokens);
  return root.preOrderTraversal();
}
