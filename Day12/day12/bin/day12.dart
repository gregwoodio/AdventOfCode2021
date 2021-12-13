import 'dart:io';

class Cave {
  String name;
  List<Cave> paths = List.empty(growable: true);
  bool isSmallCave = true;
  bool isVisited = false;

  Cave(this.name) {
    for (var ch in name.codeUnits) {
      if (ch < 97 || ch > 122) {
        isSmallCave = false;
        break;
      }
    }
  }

  @override
  String toString() {
    return name;
  }
}

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day12_input.txt').readAsLinesSync();
  print(solve(input));
  print(solve(input, true));
}

int solve(List<String> input, [bool isPartTwo = false]) {
  Map<String, Cave> caves = {};

  for (var line in input) {
    var parts = line.split('-');
    late Cave cave1;
    late Cave cave2;

    if (caves.containsKey(parts[0])) {
      cave1 = caves[parts[0]]!;
    } else {
      cave1 = Cave(parts[0]);
      caves[parts[0]] = cave1;
    }

    if (caves.containsKey(parts[1])) {
      cave2 = caves[parts[1]]!;
    } else {
      cave2 = Cave(parts[1]);
      caves[parts[1]] = cave2;
    }

    cave1.paths.add(cave2);
    cave2.paths.add(cave1);
  }

  var start = caves['start']!;
  var paths = traverse(caves, start, [], '', isPartTwo);

  return paths.length;
}

List<String> traverse(Map<String, Cave> caves, Cave curr, List<String> paths,
    String currPath, bool isPartTwo) {
  if (currPath.isNotEmpty) {
    currPath += ',';
  }

  currPath += curr.name;

  if (curr.name == 'end') {
    paths.add(currPath);
    return paths;
  }

  for (var cave in curr.paths) {
    if ((!isPartTwo &&
            cave.isSmallCave &&
            !currPath.contains('${cave.name},')) ||
        (isPartTwo &&
            cave.isSmallCave &&
            canVisitSmallCave(cave.name, currPath)) ||
        !cave.isSmallCave) {
      traverse(caves, cave, paths, currPath, isPartTwo);
    }
  }

  return paths;
}

bool canVisitSmallCave(String caveName, String visitedCaves) {
  if (caveName == 'start') {
    return false; // can't revisit start
  }

  var caves = visitedCaves
      .split(',')
      .where((cave) => cave == cave.toLowerCase()); // only consider small caves

  Map<String, int> visitCounts = {};

  for (var cave in caves) {
    if (visitCounts.containsKey(cave)) {
      visitCounts[cave] = visitCounts[cave]! + 1;
    } else {
      visitCounts[cave] = 1;
    }
  }

  if (visitCounts.values.every((count) => count < 2)) {
    return true;
  }

  var visitedTwice = visitCounts.entries
      .where((caveVisit) => caveVisit.value == 2)
      .map((entry) => entry.key)
      .toSet();
  return visitedTwice.length <= 1 && !visitedTwice.contains(caveName);

  // var regex = RegExp("$caveName,");
  // var matches = regex.allMatches(visitedCaves);
  // return matches.length;
}
