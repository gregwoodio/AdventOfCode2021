import 'dart:io';

class Point3D {
  int x;
  int y;
  int z;

  Point3D(this.x, this.y, this.z);

  @override
  bool operator ==(Object other) {
    var o = other as Point3D;
    return o.x == x && o.y == y && o.z == z;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;
}

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day22_input.txt').readAsLinesSync();
  print(partOne(input));
}

int partOne(List<String> input) {
  Map<Point3D, bool> map = {};
  var regex = RegExp(
      r'(on|off) x=(-?[0-9]+)..(-?[0-9]+),y=(-?[0-9]+)..(-?[0-9]+),z=(-?[0-9]+)..(-?[0-9]+)');

  for (var line in input) {
    var match = regex.firstMatch(line);
    var isOn = match!.group(1) == 'on';
    var lowX = int.parse(match.group(2)!);
    var highX = int.parse(match.group(3)!);
    var lowY = int.parse(match.group(4)!);
    var highY = int.parse(match.group(5)!);
    var lowZ = int.parse(match.group(6)!);
    var highZ = int.parse(match.group(7)!);

    // skip for part one
    if (lowX < -50 ||
        highX > 50 ||
        lowY < -50 ||
        highY > 50 ||
        lowZ < -50 ||
        highZ > 50) {
      continue;
    }

    for (var x = lowX; x <= highX; x++) {
      for (var y = lowY; y <= highY; y++) {
        for (var z = lowZ; z <= highZ; z++) {
          var p = Point3D(x, y, z);
          map[p] = isOn;
        }
      }
    }
  }

  return map.values.where((val) => val == true).length;
}
