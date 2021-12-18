import 'dart:io';

class TreeNode {
  TreeNode? left;
  TreeNode? right;
  TreeNode? parent;
  int? value;
  bool onLeft = true;
  int depth = 0;

  @override
  String toString() {
    var sb = StringBuffer();

    if (value == null) {
      sb.write('[');
      sb.write(left?.toString());
      sb.write(',');
      sb.write(right?.toString());
      sb.write(']');
    } else {
      sb.write(value);
    }

    return sb.toString();
  }

  int magnitude() {
    if (value != null) {
      return value!;
    }

    return 3 * left!.magnitude() + 2 * right!.magnitude();
  }
}

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day18_input.txt').readAsLinesSync();
  print(partOne(input));
  print(partTwo(input));
}

int partOne(List<String> input) {
  var tree = parseTree(input[0]);

  for (var i = 1; i < input.length; i++) {
    var node = TreeNode();
    node.left = tree;
    tree!.parent = node;
    node.right = parseTree(input[i]);
    node.right!.parent = node;

    reduce(node);
    // print(node);
    tree = parseTree(node.toString());
  }

  return tree!.magnitude();
}

int partTwo(List<String> input) {
  var largest = 0;
  for (var i = 0; i < input.length; i++) {
    for (var j = 0; j < input.length; j++) {
      if (i == j) {
        continue;
      }

      var node = TreeNode();
      node.left = parseTree(input[i]);
      node.left!.parent = node;

      node.right = parseTree(input[j]);
      node.right!.parent = node;

      reduce(node);
      var magnitude = node.magnitude();
      if (magnitude > largest) {
        largest = magnitude;
      }
    }
  }

  return largest;
}

TreeNode? parseTree(String input) {
  TreeNode? root;
  TreeNode? node;
  TreeNode? parent;

  for (var ch in input.split('')) {
    if (ch == '[') {
      node = TreeNode();

      root ??= node;
      if (parent != null) {
        node.parent = parent;
        if (parent.onLeft) {
          parent.left = node;
        } else {
          parent.right = node;
        }
      }
      parent = node;
    } else if (ch == ',') {
      parent!.onLeft = false;
    } else if (ch == ']') {
      parent = parent!.parent;
    } else {
      int val = int.parse(ch);
      var valueNode = TreeNode();
      valueNode.value = val;

      if (parent!.onLeft) {
        parent.left = valueNode;
        valueNode.parent = parent;
      } else {
        parent.right = valueNode;
        valueNode.parent = parent;
      }
    }
  }

  return root;
}

void updateDepth(TreeNode? node, int value) {
  if (node != null) {
    node.depth = value;
    updateDepth(node.left, value + 1);
    updateDepth(node.right, value + 1);
  }
}

void reduce(TreeNode node) {
  // print(node);

  updateDepth(node, 0);

  var explodable = findExplodable(node);
  if (explodable != null) {
    explode(explodable);
    reduce(node);
    return;
  }

  var splittable = findSplitable(node);
  if (splittable != null) {
    var leftVal = (splittable.value! / 2).floor();
    var rightVal = (splittable.value! / 2).ceil();

    var split = TreeNode();
    var left = TreeNode();
    left.value = leftVal;
    split.left = left;
    left.parent = split;

    var right = TreeNode();
    right.value = rightVal;
    split.right = right;
    right.parent = split;
    split.parent = splittable.parent;

    if (splittable.parent!.left == splittable) {
      splittable.parent!.left = split;
    } else {
      splittable.parent!.right = split;
    }

    reduce(node);
    return;
  }
}

TreeNode? findExplodable(TreeNode? node) {
  if (node == null) {
    return null;
  }

  if (node.depth >= 4 &&
      node.left != null &&
      node.left!.value != null &&
      node.right != null &&
      node.right!.value != null) {
    return node;
  }

  var left = findExplodable(node.left);
  if (left != null) {
    return left;
  }

  var right = findExplodable(node.right);
  if (right != null) {
    return right;
  }

  return null;
}

TreeNode? findSplitable(TreeNode? node) {
  if (node == null) {
    return null;
  }

  if (node.value != null && node.value! >= 10) {
    return node;
  }

  var left = findSplitable(node.left);
  if (left != null) {
    return left;
  }

  var right = findSplitable(node.right);
  if (right != null) {
    return right;
  }

  return null;
}

void explode(TreeNode explodable) {
  var leftVal = explodable.left!.value;
  var rightVal = explodable.right!.value;
  var explodableOnLeft = explodable.parent!.left == explodable;

  TreeNode? curr = explodable.parent;
  TreeNode? prev = explodable;

  // left
  while (curr != null && curr.left == prev) {
    prev = curr;
    curr = curr.parent;
  }
  if (curr != null) {
    curr = curr.left;
    while (curr!.value == null) {
      curr = curr.right;
    }
    curr.value = curr.value! + leftVal!;
    // } else {
    //   var newLeft = TreeNode();
    //   newLeft.value = 0;
    //   explodable.parent!.left = newLeft;
    //   newLeft.parent = explodable.parent;
  }

  // right
  curr = explodable.parent;
  prev = explodable;

  while (curr != null && curr.right == prev) {
    prev = curr;
    curr = curr.parent;
  }
  if (curr != null) {
    curr = curr.right;
    while (curr!.value == null) {
      curr = curr.left;
    }
    curr.value = curr.value! + rightVal!;
    // } else {
    //   var newRight = TreeNode();
    //   newRight.value = 0;
    //   explodable.parent!.right = newRight;
    //   newRight.parent = explodable.parent;
  }

  var n = TreeNode();
  n.value = 0;
  n.parent = explodable.parent;
  if (explodableOnLeft) {
    explodable.parent!.left = n;
  } else {
    explodable.parent!.right = n;
  }
}
