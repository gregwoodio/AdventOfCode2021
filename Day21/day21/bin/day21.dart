import 'dart:io';

class Player {
  int id;
  int pos;
  int score = 0;

  Player(this.id, this.pos);

  void move(int spaces) {
    pos = (pos + spaces) % 10;
    score += pos + 1;
  }
}

void main(List<String> arguments) {
  var input =
      File('${Directory.current.path}\\bin\\day21_input.txt').readAsLinesSync();
  print(partOne(input));
}

int partOne(List<String> inputs) {
  List<Player> players = [];
  for (var i = 0; i < inputs.length; i++) {
    var parts = inputs[i].split(': ');
    players.add(Player(i + 1, int.parse(parts[1]) - 1)); // zero index
  }

  var rolls = 0;
  var nextRoll = 1;
  var turn = 0;

  while (true) {
    var sum = 0;
    for (var i = 0; i < 3; i++) {
      sum += nextRoll;
      nextRoll++;
      if (nextRoll > 100) {
        nextRoll = 1;
      }
      rolls++;
    }

    players[turn].move(sum);

    if (players[turn].score >= 1000) {
      var other = players[(turn + 1) % 2];
      return other.score * rolls;
    }

    turn = (turn + 1) % 2;
  }
}
