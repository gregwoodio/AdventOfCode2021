import 'dart:io';

import 'package:collection/collection.dart';

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day15_input.txt').readAsLinesSync();

  print(partOne(input));
}

class Node {
  String value;
  int weight = 99999;
  List<Path> paths = [];

  Node(this.value);
}

class Path {
  Node node;
  int weight;

  Path(this.node, this.weight);
}

int partOne(List<String> input) {
  var graph = makeGraph(input);

  // set start weight to zero
  graph["0,0"]!.weight = 0;

  var pq = PriorityQueue((Node a, Node b) => a.weight - b.weight);
  pq.addAll(graph.values);

  while (pq.isNotEmpty) {
    var node = pq.removeFirst();
    for (var path in node.paths) {
      if (node.weight + path.weight < path.node.weight) {
        graph[path.node.value]!.weight = node.weight + path.weight;

        // update pq ordering
        var elems = pq.removeAll();
        pq.addAll(elems);
      }
    }
  }

  return graph['${input.length - 1},${input[0].length - 1}']!.weight;
}

Map<String, Node> makeGraph(List<String> input) {
  Map<String, Node> map = {};

  for (var i = 0; i < input.length; i++) {
    var nums = input[i].split('').map((val) => int.parse(val)).toList();
    for (var j = 0; j < nums.length; j++) {
      var key = '$j,$i';
      var node = Node(key);

      if (i - 1 >= 0) {
        var above = map['$j,${i - 1}']!;
        node.paths.add(Path(above, nums[j]));
        above.paths.add(Path(node, nums[j]));
      }

      if (j - 1 >= 0) {
        var left = map['${j - 1},$i']!;
        node.paths.add(Path(left, nums[j]));
        left.paths.add(Path(node, nums[j]));
      }

      map[key] = node;
    }
  }

  return map;
}
