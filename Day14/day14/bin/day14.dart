import 'dart:io';

void main(List<String> arguments) {
  var input =
      File("${Directory.current.path}\\bin\\day14_input.txt").readAsLinesSync();
  print(solve(input));
  print(solve(input, true));
}

int solve(List<String> input, [bool isPartTwo = false]) {
  var polymer = input[0];

  Map<String, String> inst = {};
  for (var i = 2; i < input.length; i++) {
    var parts = input[i].split(' -> ');
    inst[parts[0]] = parts[1];
  }

  var steps = isPartTwo ? 40 : 10;

  for (var step = 0; step < steps; step++) {
    var newPolymer = '';

    for (var i = 0; i < polymer.length - 1; i++) {
      var pair = polymer.substring(i, i + 2);
      newPolymer += '${pair[0]}${inst[pair]}';
    }
    newPolymer += polymer[polymer.length - 1];

    polymer = newPolymer;
  }

  Map<String, int> counts = {};
  var letters = polymer.split('');
  for (var letter in letters) {
    if (counts.containsKey(letter)) {
      counts[letter] = counts[letter]! + 1;
    } else {
      counts[letter] = 1;
    }
  }

  var mostCommonElement =
      counts.values.reduce((curr, prev) => curr > prev ? curr : prev);
  var leastCommonElement =
      counts.values.reduce((curr, prev) => curr < prev ? curr : prev);

  return mostCommonElement - leastCommonElement;
}
