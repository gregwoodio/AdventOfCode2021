import 'dart:io';
import 'dart:math';

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day20_input.txt').readAsLinesSync();

  print(solve(input));
  print(solve(input, true));
}

int solve(List<String> input, [bool isPartTwo = false]) {
  Set<Point<int>> set = {};

  var enhancement = input[0];
  var lowX = -1;
  var highX = input[2].length + 1;
  var lowY = -1;
  var highY = input.length + 1;

  for (var i = 2; i < input.length; i++) {
    for (var j = 0; j < input[i].length; j++) {
      if (input[i][j] == '#') {
        set.add(Point(j, i));
      }
    }
  }

  var maxSteps = isPartTwo ? 50 : 2;

  for (var step = 0; step < maxSteps; step++) {
    var xs = set.map((p) => p.x);
    var ys = set.map((p) => p.y);

    lowX = xs.reduce((a, b) => min(a, b));
    highX = xs.reduce((a, b) => max(a, b));

    lowY = ys.reduce((a, b) => min(a, b));
    highY = ys.reduce((a, b) => max(a, b));

    if (step.isOdd &&
        enhancement[0] == '#' &&
        enhancement[enhancement.length - 1] == '.') {
      // add fake border
      for (var x = lowX - 2; x < highX + 3; x++) {
        set.add(Point(x, lowY - 1));
        set.add(Point(x, lowY - 2));
        set.add(Point(x, highY + 1));
        set.add(Point(x, highY + 2));
      }

      for (var y = lowY - 2; y < highY + 3; y++) {
        set.add(Point(lowX - 1, y));
        set.add(Point(lowX - 2, y));
        set.add(Point(highX + 1, y));
        set.add(Point(highX + 2, y));
      }
    }

    Set<Point<int>> newSet = {};
    for (var y = lowY - 1; y < highY + 2; y++) {
      for (var x = lowX - 1; x < highX + 2; x++) {
        var bin = [
          set.contains(Point(x - 1, y - 1)) ? "1" : "0",
          set.contains(Point(x, y - 1)) ? "1" : "0",
          set.contains(Point(x + 1, y - 1)) ? "1" : "0",
          set.contains(Point(x - 1, y)) ? "1" : "0",
          set.contains(Point(x, y)) ? "1" : "0",
          set.contains(Point(x + 1, y)) ? "1" : "0",
          set.contains(Point(x - 1, y + 1)) ? "1" : "0",
          set.contains(Point(x, y + 1)) ? "1" : "0",
          set.contains(Point(x + 1, y + 1)) ? "1" : "0",
        ].join('');

        var num = int.parse(bin, radix: 2);
        if (enhancement[num] == '#') {
          newSet.add(Point(x, y));
        }
      }
    }

    set = newSet;
  }

  // return 'on' values
  return set.length;
}
