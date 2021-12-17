import 'dart:io';

class Probe {
  int xVelocity;
  int yVelocity;
  int xPos = 0;
  int yPos = 0;
  int highestY = 0;

  Probe(this.xVelocity, this.yVelocity);

  step() {
    xPos += xVelocity;
    yPos += yVelocity;

    if (yPos > highestY) {
      highestY = yPos;
    }

    if (xVelocity > 0) {
      xVelocity--;
    } else if (xVelocity < 0) {
      xVelocity++;
    }
    yVelocity--;
  }

  bool isIn(TargetArea target) {
    return xPos >= target.lowX &&
        xPos <= target.highX &&
        yPos >= target.lowY &&
        yPos <= target.highY;
  }
}

class TargetArea {
  late int lowX;
  late int highX;
  late int lowY;
  late int highY;

  TargetArea(String input) {
    var parts = input.split(' ');
    var xs = parts[2]
        .substring(2, parts[2].length - 1)
        .split('..')
        .map((val) => int.parse(val))
        .toList();
    var ys =
        parts[3].substring(2).split('..').map((val) => int.parse(val)).toList();

    lowX = xs[0];
    highX = xs[1];
    lowY = ys[0];
    highY = ys[1];
  }
}

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day17_input.txt').readAsLinesSync();
  print(solve(input[0]));
  print(solve(input[0], true));
}

int solve(String input, [bool isPartTwo = false]) {
  var target = TargetArea(input);
  var highestY = 0;
  var possibleShotCount = 0;

  for (var x = 1; x <= target.highX; x++) {
    for (var y = target.lowY * 2; y <= 300; y++) {
      var probe = Probe(x, y);

      while (true) {
        probe.step();

        // win condition
        if (probe.isIn(target)) {
          // print('$x,$y');
          possibleShotCount++;
          if (probe.highestY > highestY) {
            highestY = probe.highestY;
          }
          break;
        }

        // lose condition
        if ((probe.xVelocity == 0 &&
                (probe.xPos < target.lowX || probe.xPos > target.highX)) ||
            probe.yPos < target.lowY) {
          break;
        }
      }
    }
  }

  if (isPartTwo) {
    return possibleShotCount;
  }
  return highestY;
}
