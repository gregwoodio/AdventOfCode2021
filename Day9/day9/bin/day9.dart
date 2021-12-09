import 'dart:io';

void main(List<String> arguments) {
  var dir = Directory.current;
  var input = File("${dir.path}\\bin\\day9_input.txt").readAsLinesSync();
  print(partOne(input));
  print(partTwo(input));
}

int partOne(List<String> input) {
  List<List<int>> cave = [];

  for (var line in input) {
    cave.add(line.split('').map((num) => int.parse(num)).toList());
  }

  int count = 0;

  for (var i = 0; i < cave.length; i++) {
    for (var j = 0; j < cave[0].length; j++) {
      var isLower = true;
      if (i - 1 >= 0) {
        isLower &= cave[i][j] < cave[i - 1][j];
      }

      if (i + 1 < cave.length) {
        isLower &= cave[i][j] < cave[i + 1][j];
      }

      if (j - 1 >= 0) {
        isLower &= cave[i][j] < cave[i][j - 1];
      }

      if (j + 1 < cave[i].length) {
        isLower &= cave[i][j] < cave[i][j + 1];
      }

      if (isLower) {
        count += cave[i][j] + 1;
      }
    }
  }

  return count;
}

class Coord {
  int x;
  int y;
  int value;
  int basinNum = -1;

  Coord(this.x, this.y, this.value);
}

int partTwo(List<String> input) {
  List<List<int>> cave = [];

  for (var line in input) {
    cave.add(line.split('').map((num) => int.parse(num)).toList());
  }

  List<List<Coord>> caveCoords = [];

  for (var i = 0; i < cave.length; i++) {
    caveCoords.add([]);
    for (var j = 0; j < cave[0].length; j++) {
      caveCoords[i].add(Coord(i, j, cave[i][j]));
    }
  }

  // flood
  int basinNumber = 0;
  for (var i = 0; i < cave.length; i++) {
    for (var j = 0; j < cave[0].length; j++) {
      if (caveCoords[i][j].value != 9 && caveCoords[i][j].basinNum == -1) {
        flood(caveCoords, i, j, basinNumber);
        basinNumber++;
      }
    }
  }

  var coords = caveCoords.expand((e) => e);
  Map<int, List<Coord>> map = {};
  for (var coord in coords) {
    if (coord.basinNum == -1) {
      continue;
    }

    if (!map.containsKey(coord.basinNum)) {
      map[coord.basinNum] = [];
    }

    map[coord.basinNum]!.add(coord);
  }

  var sizes = map.values.map((v) => v.length).toList();
  sizes.sort();
  return sizes[sizes.length - 1] *
      sizes[sizes.length - 2] *
      sizes[sizes.length - 3];
}

void flood(List<List<Coord>> coords, int i, int j, int basinNumber) {
  if (i >= 0 &&
      i < coords.length &&
      j >= 0 &&
      j < coords[i].length &&
      coords[i][j].value != 9 &&
      coords[i][j].basinNum == -1) {
    coords[i][j].basinNum = basinNumber;

    flood(coords, i - 1, j, basinNumber);
    flood(coords, i + 1, j, basinNumber);
    flood(coords, i, j - 1, basinNumber);
    flood(coords, i, j + 1, basinNumber);
  }
}
