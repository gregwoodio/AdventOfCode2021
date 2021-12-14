import 'dart:io';

void main(List<String> arguments) {
  var input =
      File("${Directory.current.path}\\bin\\day14_input.txt").readAsLinesSync();
  print(solve(input));
  print(solve(input, true));
}

int solve(List<String> input, [bool isPartTwo = false]) {
  Map<String, int> pairs = {};
  for (var i = 0; i < input[0].length - 1; i++) {
    var pair = input[0].substring(i, i + 2);
    if (pairs.containsKey(pair)) {
      pairs[pair] = pairs[pair]! + 1;
    } else {
      pairs[pair] = 1;
    }
  }

  Map<String, String> inst = {};
  for (var i = 2; i < input.length; i++) {
    var parts = input[i].split(' -> ');
    inst[parts[0]] = parts[1];
  }

  var steps = isPartTwo ? 40 : 10;

  for (var step = 0; step < steps; step++) {
    Map<String, int> newPairs = {};
    for (var pair in pairs.entries) {
      var elem = inst[pair.key];
      var key1 = "${pair.key[0]}$elem";
      var key2 = "$elem${pair.key[1]}";

      if (newPairs.containsKey(key1)) {
        newPairs[key1] = newPairs[key1]! + pair.value;
      } else {
        newPairs[key1] = pair.value;
      }
      if (newPairs.containsKey(key2)) {
        newPairs[key2] = newPairs[key2]! + pair.value;
      } else {
        newPairs[key2] = pair.value;
      }
    }

    pairs = newPairs;
  }

  Map<String, int> counts = {};
  for (var pair in pairs.entries) {
    for (var letter in pair.key.split('')) {
      if (counts.containsKey(letter)) {
        counts[letter] = counts[letter]! + pair.value;
      } else {
        counts[letter] = pair.value;
      }
    }
  }

  // all counts are doubled because the pairs overlap.
  // To get an accurate count we can add one to the first
  // and last element (which haven't changed) then divide by 2.
  counts[input[0][0]] = counts[input[0][0]]! + 1;
  counts[input[0][input[0].length - 1]] =
      counts[input[0][input[0].length - 1]]! + 1;

  var mostCommonElement =
      counts.values.reduce((curr, prev) => curr > prev ? curr : prev);
  var leastCommonElement =
      counts.values.reduce((curr, prev) => curr < prev ? curr : prev);

  return (mostCommonElement ~/ 2) - (leastCommonElement ~/ 2);
}
