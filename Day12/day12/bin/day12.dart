import 'dart:io';

class Cave {
  String name;
  List<Cave> paths = List.empty(growable: true);
  bool isSmallCave = true;
  bool isVisited = false;

  Cave(this.name) {
    for (var ch in name.codeUnits) {
      if (ch < 97 && ch > 122) {
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
  var input = File("${Directory.current.path}\\bin\\day12_sample_input1.txt")
      .readAsLinesSync();
  print(partOne(input));
}

int partOne(List<String> input) {
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

  var start = caves["start"]!;
  var paths = traverse(caves, start, []);

  return -1;
}

List<String> traverse(Map<String, Cave> caves, Cave curr, List<String> paths) {
  paths.add(curr.name);
  if (paths.length > 100) {
    return paths;
  }
  for (var cave in curr.paths) {
    if (cave.isSmallCave && !cave.isVisited) {
      cave.isVisited = true;
      paths.addAll(traverse(caves, cave, paths));
    } else if (!cave.isSmallCave) {
      paths.addAll(traverse(caves, cave, paths));
    }
  }
  return paths;
}
