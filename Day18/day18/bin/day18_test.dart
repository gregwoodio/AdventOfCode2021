import 'package:test/test.dart';
import 'day18.dart';

void main() {
  group('day 18 tree building tests', () {
    test('simple value tree', () {
      var input = '[1,2]';
      var tree = parseTree(input);

      expect(tree, isNotNull);
      expect(tree!.left, isNotNull);
      expect(tree.left!.value, isNotNull);
      expect(tree.left!.value, equals(1));
      expect(tree.right, isNotNull);
      expect(tree.right!.value, isNotNull);
      expect(tree.right!.value, equals(2));
    });

    test('tree with nested values on the left', () {
      var input = '[[1,2],3]';
      var tree = parseTree(input);

      expect(tree, isNotNull);
      expect(tree!.left, isNotNull);
      expect(tree.left!.left, isNotNull);
      expect(tree.left!.left!.value, equals(1));
      expect(tree.left!.right, isNotNull);
      expect(tree.left!.right!.value, equals(2));
      expect(tree.right, isNotNull);
      expect(tree.right!.value, equals(3));
    });

    test('tree with nested values on the right', () {
      var input = '[9,[8,7]]';
      var tree = parseTree(input);

      expect(tree, isNotNull);
      expect(tree!.left, isNotNull);
      expect(tree.left!.value, equals(9));
      expect(tree.right, isNotNull);
      expect(tree.right!.left, isNotNull);
      expect(tree.right!.left!.value, equals(8));
      expect(tree.right!.right, isNotNull);
      expect(tree.right!.right!.value, equals(7));
    });

    test('can you believe nesting on both sides?', () {
      var input = '[[1,9],[8,5]]';
      var tree = parseTree(input);

      expect(tree, isNotNull);
      expect(tree!.left, isNotNull);
      expect(tree.left!.left!.value, equals(1));
      expect(tree.left!.right!.value, equals(9));
      expect(tree.right, isNotNull);
      expect(tree.right!.left!.value, equals(8));
      expect(tree.right!.right!.value, equals(5));
    });

    test('deeply nested tree', () {
      var input =
          '[[[[1,3],[5,3]],[[1,3],[8,7]]],[[[4,9],[6,9]],[[8,2],[7,3]]]]';
      var tree = parseTree(input);

      expect(tree, isNotNull);
      expect(tree!.left!.right!.right!.left!.value, equals(8));
      expect(tree.right!.left!.right!.left!.value, equals(6));
    });
  });

  test('update depth', () {
    var input = '[[[[[9,8],1],2],3],4]';
    var tree = parseTree(input);

    updateDepth(tree, 0);
    expect(tree!.left!.left!.left!.left, isNotNull);
    expect(tree.left!.left!.left!.left!.depth, equals(4));
  });

  group('explode', () {
    test('explode 1', () {
      var input = '[[[[[9,8],1],2],3],4]';
      var tree = parseTree(input);
      updateDepth(tree, 0);

      var explodable = findExplodable(tree);
      explode(explodable!);

      expect(tree!.left!.left!.left!.left!.value, equals(0));
      expect(tree.left!.left!.left!.right!.value, equals(9));
    });

    test('explode 2', () {
      var input = '[7,[6,[5,[4,[3,2]]]]]';
      var tree = parseTree(input);
      updateDepth(tree, 0);

      var explodable = findExplodable(tree);
      explode(explodable!);

      expect(tree!.right!.right!.right!.right!.value, equals(0));
      expect(tree.right!.right!.right!.left!.value, equals(7));
    });
  });

  test('reduce', () {
    var input = '[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]';
    var tree = parseTree(input);
    reduce(tree!);

    expect(tree, isNotNull);
    expect(tree.toString(), equals('[[[[0,7],4],[[7,8],[6,0]]],[8,1]]'));
  });

  test('magnitude', () {
    Map<String, int> testCases = {
      '[1,9]': 21,
      '[[1,2],[[3,4],5]]': 143,
      '[[[[0,7],4],[[7,8],[6,0]]],[8,1]]': 1384,
      '[[[[1,1],[2,2]],[3,3]],[4,4]]': 445,
      '[[[[3,0],[5,3]],[4,4]],[5,5]]': 791,
      '[[[[5,0],[7,4]],[5,5]],[6,6]]': 1137,
      '[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]': 3488
    };

    for (var tc in testCases.entries) {
      var tree = parseTree(tc.key);

      var magnitude = tree!.magnitude();
      expect(magnitude, equals(tc.value));
    }
  });

  test('part one', () {
    var input = '''[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]'''
        .split('\n');
    var magnitude = partOne(input);
    expect(magnitude, equals(4140));
  });

  test('part two', () {
    var input = '''[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]'''
        .split('\n');
    var magnitude = partTwo(input);
    expect(magnitude, equals(3993));
  });
}
