import 'dart:io';

class BingoSquare {
  bool marked = false;
  int value;

  BingoSquare(this.value);
}

class Board {
  List<List<BingoSquare>> squares;

  Board(this.squares);
}

class Game {
  List<int> numbers;
  List<Board> boards;
  Map<int, List<BingoSquare>> map;

  Game(this.numbers, this.boards, this.map);
}

void main() async {
  String contents = await File("./day4_sample_input.txt").readAsString();
  List<String> input = contents.split("\n");

  print("Part one: ${partOne(input)}");
  print("Part two: ${partTwo(input)}");
}

int partOne(List<String> input) {
  var game = parseInput(input);

  for (var i = 0; i < game.numbers.length; i++) {
    var number = game.numbers[i];
    var squares = game.map[number];
    if (squares != null) {
      for (var i = 0; i < squares.length; i++) {
        squares[i].marked = true;
      }
    }

    if (i > 5) {
      var score = checkWin(game.boards, number);

      if (score != -1) {
        return score;
      }
    }
  }

  return -1;
}

int partTwo(List<String> input) {
  var game = parseInput(input);

  for (var i = 0; i < game.numbers.length; i++) {
    var number = game.numbers[i];
    var squares = game.map[number];
    if (squares != null) {
      for (var i = 0; i < squares.length; i++) {
        squares[i].marked = true;
      }
    }

    if (i > 5) {
      var score = checkWinPartTwo(game.boards, number);

      if (score != -1) {
        return score;
      }
    }
  }

  return -1;
}

Game parseInput(List<String> input) {
  List<int> numbers = [];
  for (String num in input[0].split(",")) {
    var value = int.parse(num);
    numbers.add(value);
  }

  List<Board> boards = [];
  Map<int, List<BingoSquare>> map = {};

  for (var i = 2; i < input.length; i += 6) {
    List<List<BingoSquare>> squares = [];
    for (var j = i; j < i + 5; j++) {
      List<BingoSquare> squareRow = [];
      var row = input[j].split(RegExp(r" +"));
      for (var numStr in row) {
        var num = int.tryParse(numStr);
        if (num != null) {
          var square = BingoSquare(num);
          if (map.containsKey(num)) {
            var list = map[num]!;
            list.add(square);
            map[num] = list;
          } else {
            map[num] = [square];
          }

          squareRow.add(square);
        }
      }

      squares.add(squareRow);
    }

    print(squares);

    boards.add(new Board(squares));
  }

  return Game(numbers, boards, map);
}

int checkWin(List<Board> boards, int lastCalled) {
  for (var board in boards) {
    for (var i = 0; i < board.squares.length; i++) {
      var horizontalWin = true;
      var verticalWin = true;
      for (var j = 0; j < board.squares[i].length; j++) {
        if (!board.squares[i][j].marked) {
          horizontalWin = false;
        }

        if (!board.squares[j][i].marked) {
          verticalWin = false;
        }
      }

      if (verticalWin || horizontalWin) {
        return getScore(board, lastCalled);
      }
    }
  }

  return -1;
}

int checkWinPartTwo(List<Board> boards, int lastCalled) {
  for (var b = 0; b < boards.length; b++) {
    var board = boards[b];
    for (var i = 0; i < board.squares.length; i++) {
      var horizontalWin = true;
      var verticalWin = true;
      for (var j = 0; j < board.squares[i].length; j++) {
        if (!board.squares[i][j].marked) {
          horizontalWin = false;
        }

        if (!board.squares[j][i].marked) {
          verticalWin = false;
        }
      }

      if (verticalWin || horizontalWin && board.squares.length > 1) {
        boards.removeAt(b);
        b--;
        break;
        // return getScore(board, lastCalled);
      } else if (verticalWin || horizontalWin && board.squares.length == 1) {
        return getScore(board, lastCalled);
      }
    }
  }

  return -1;
}

int getScore(Board board, int lastCalled) {
  var sum = 0;
  for (var i = 0; i < board.squares.length; i++) {
    for (var j = 0; j < board.squares[i].length; j++) {
      if (!board.squares[i][j].marked) {
        sum += board.squares[i][j].value;
      }
    }
  }

  return sum * lastCalled;
}
