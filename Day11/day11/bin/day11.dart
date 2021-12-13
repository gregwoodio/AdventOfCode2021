import 'dart:io';

class Octopus {
  int energy;
  bool hasFlashed = false;

  Octopus(this.energy);

  @override
  String toString() {
    return "$energy";
  }
}

void main(List<String> arguments) {
  var input = File("${Directory.current.path}\\bin\\day11_input.txt")
      .readAsLinesSync()
      .map((line) =>
          line.split('').map((val) => Octopus(int.parse(val))).toList())
      .toList();

  var p1 = input
      .map((list) => list.map((octopus) => Octopus(octopus.energy)).toList())
      .toList();
  var p2 = input
      .map((list) => list.map((octopus) => Octopus(octopus.energy)).toList())
      .toList();
  print(solve(p1));
  print(solve(p2, true));
}

void flash(List<List<Octopus>> octopi, int i, int j) {
  octopi[i][j].hasFlashed = true;

  if (i - 1 >= 0) {
    if (j - 1 >= 0) {
      octopi[i - 1][j - 1].energy++;
      if (!octopi[i - 1][j - 1].hasFlashed && octopi[i - 1][j - 1].energy > 9) {
        flash(octopi, i - 1, j - 1);
      }
    }
    octopi[i - 1][j].energy++;
    if (!octopi[i - 1][j].hasFlashed && octopi[i - 1][j].energy > 9) {
      flash(octopi, i - 1, j);
    }
    if (j + 1 < octopi[i].length) {
      octopi[i - 1][j + 1].energy++;
      if (!octopi[i - 1][j + 1].hasFlashed && octopi[i - 1][j + 1].energy > 9) {
        flash(octopi, i - 1, j + 1);
      }
    }
  }

  if (j - 1 >= 0) {
    octopi[i][j - 1].energy++;
    if (!octopi[i][j - 1].hasFlashed && octopi[i][j - 1].energy > 9) {
      flash(octopi, i, j - 1);
    }
  }
  if (j + 1 < octopi[i].length) {
    octopi[i][j + 1].energy++;
    if (!octopi[i][j + 1].hasFlashed && octopi[i][j + 1].energy > 9) {
      flash(octopi, i, j + 1);
    }
  }

  if (i + 1 < octopi.length) {
    if (j - 1 >= 0) {
      octopi[i + 1][j - 1].energy++;
      if (!octopi[i + 1][j - 1].hasFlashed && octopi[i + 1][j - 1].energy > 9) {
        flash(octopi, i + 1, j - 1);
      }
    }
    octopi[i + 1][j].energy++;
    if (!octopi[i + 1][j].hasFlashed && octopi[i + 1][j].energy > 9) {
      flash(octopi, i + 1, j);
    }
    if (j + 1 < octopi[i].length) {
      octopi[i + 1][j + 1].energy++;
      if (!octopi[i + 1][j + 1].hasFlashed && octopi[i + 1][j + 1].energy > 9) {
        flash(octopi, i + 1, j + 1);
      }
    }
  }
}

int solve(List<List<Octopus>> octopi, [bool isPartTwo = false]) {
  int flashes = 0;
  int totalSteps = 100;

  for (var step = 0; isPartTwo || step < totalSteps; step++) {
    // print('\n==== Step $step ====\n');

    // increase energy
    for (var octopusRow in octopi) {
      // print(octopusRow);
      for (var octopus in octopusRow) {
        octopus.energy++;
        octopus.hasFlashed = false;
      }
    }

    for (var i = 0; i < octopi.length; i++) {
      for (var j = 0; j < octopi[i].length; j++) {
        if (!octopi[i][j].hasFlashed && octopi[i][j].energy > 9) {
          flash(octopi, i, j);
        }
      }
    }

    var currentFlashes = 0;
    for (var octopusRow in octopi) {
      for (var octopus in octopusRow) {
        if (octopus.hasFlashed) {
          flashes++;
          currentFlashes++;
          octopus.energy = 0;
        }
      }
    }

    if (isPartTwo && currentFlashes == 100) {
      return step + 1;
    }
  }

  // print('\n==== After $totalSteps steps ====\n');
  // for (var octopusRow in octopi) {
  //   // debug
  //   print(octopusRow);
  // }

  return flashes;
}
