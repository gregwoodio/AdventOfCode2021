import 'dart:io';

void main(List<String> arguments) {
  var dir = Directory.current;
  var input = File("${dir.path}\\bin\\day10_input.txt").readAsLinesSync();
  // print(partOne(input));
  print(partTwo(input));
}

int partOne(List<String> input) {
  // find syntax errors only

  var openBrackets = RegExp(r"[<{\[(]");
  var score = 0;

  for (var line in input) {
    List<String> stack = [];
    for (var i = 0; i < line.length; i++) {
      if (openBrackets.hasMatch(line[i])) {
        stack.add(line[i]);
      } else if (line[i] == ")" && stack[stack.length - 1] != "(" ||
          line[i] == "]" && stack[stack.length - 1] != "[" ||
          line[i] == "}" && stack[stack.length - 1] != "{" ||
          line[i] == ">" && stack[stack.length - 1] != "<") {
        print("Syntax error: unexpected token ${line[i]}");
        if (line[i] == ")") {
          score += 3;
        } else if (line[i] == "]") {
          score += 57;
        } else if (line[i] == "}") {
          score += 1197;
        } else if (line[i] == ">") {
          score += 25137;
        }

        break;
      } else if (line[i] == ")" ||
          line[i] == "]" ||
          line[i] == "}" ||
          line[i] == ">") {
        // must match, pop element off stack
        if (stack.isNotEmpty) {
          stack.removeAt(stack.length - 1);
        } else {
          print("nothing in the stack!");
        }
      }
    }
  }

  return score;
}

int partTwo(List<String> input) {
  var openBrackets = RegExp(r"[<{\[(]");
  List<int> scores = [];

  for (var line in input) {
    List<String> stack = [];
    var isValid = true;

    for (var i = 0; i < line.length; i++) {
      if (openBrackets.hasMatch(line[i])) {
        stack.add(line[i]);
      } else if (line[i] == ")" && stack[stack.length - 1] != "(" ||
          line[i] == "]" && stack[stack.length - 1] != "[" ||
          line[i] == "}" && stack[stack.length - 1] != "{" ||
          line[i] == ">" && stack[stack.length - 1] != "<") {
        // this time, skip lines with syntax errors
        isValid = false;
        break;
      } else if (line[i] == ")" ||
          line[i] == "]" ||
          line[i] == "}" ||
          line[i] == ">") {
        // must match, pop element off stack
        if (stack.isNotEmpty) {
          stack.removeAt(stack.length - 1);
        } else {
          print("nothing in the stack!");
        }
      }
    }

    if (isValid) {
      var score = 0;
      while (stack.isNotEmpty) {
        score *= 5;

        if (stack[stack.length - 1] == "(") {
          score += 1;
        } else if (stack[stack.length - 1] == "[") {
          score += 2;
        } else if (stack[stack.length - 1] == "{") {
          score += 3;
        } else if (stack[stack.length - 1] == "<") {
          score += 4;
        }

        stack.removeAt(stack.length - 1);
      }

      scores.add(score);
    }
  }

  scores.sort();
  return scores[scores.length ~/ 2]; // integer division
}
