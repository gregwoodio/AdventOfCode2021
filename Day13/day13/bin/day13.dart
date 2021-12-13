import 'dart:io';

class Coord {
  int x;
  int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    return other is Coord && x == other.x && y == other.y;
  }

  @override
  String toString() {
    return "$x,$y";
  }

  @override
  int get hashCode => x * 10000 + y;
}

void main(List<String> arguments) {
  var input =
      File("${Directory.current.path}\\bin\\day13_input.txt").readAsLinesSync();

  // print(solve(input).keys.length);
  printDots(solve(input, true));
}

Map<Coord, bool> solve(List<String> input, [bool isPartTwo = false]) {
  Map<Coord, bool> dots = {};

  var line = 0;
  // check dot instructions
  for (; line < input.length && input[line].isNotEmpty; line++) {
    var parts = input[line].split(',');
    var x = int.parse(parts[0]);
    var y = int.parse(parts[1]);

    dots[Coord(x, y)] = true;
  }

  line++; // skip blank line

  // read fold instructions
  for (; line < input.length; line++) {
    var dotList = dots.keys.toList();
    dots = {};

    var parts = input[line].split(' ')[2].split('=');
    var axis = parts[0];
    var fold = int.parse(parts[1]);

    if (axis == 'x') {
      for (var dot in dotList) {
        if (dot.x < fold) {
          dots[dot] = true;
        } else {
          // what about if the dot is on the fold line?
          dots[Coord(fold - (dot.x - fold), dot.y)] = true;
        }
      }
    } else if (axis == 'y') {
      for (var dot in dotList) {
        if (dot.y < fold) {
          dots[dot] = true;
        } else {
          dots[Coord(dot.x, fold - (dot.y - fold))] = true;
        }
      }
    }

    if (!isPartTwo) {
      break;
    }
  }

  return dots;
}

void printDots(Map<Coord, bool> dots) {
  var dotList = dots.keys.toList();
  var maxX = 0;
  var maxY = 0;

  for (var dot in dotList) {
    if (dot.x > maxX) {
      maxX = dot.x;
    }
    if (dot.y > maxY) {
      maxY = dot.y;
    }
  }

  List<List<bool>> toPrint = List.filled(maxY + 1, []);
  for (var i = 0; i < toPrint.length; i++) {
    toPrint[i] = List.filled(maxX + 1, false);
  }
  for (var dot in dotList) {
    toPrint[dot.y][dot.x] = true;
  }

  for (var y = 0; y < toPrint.length; y++) {
    for (var x = 0; x < toPrint[y].length; x++) {
      if (toPrint[y][x]) {
        stdout.write('#');
      } else {
        stdout.write(' ');
      }
    }
    stdout.write('\n');
  }
}
