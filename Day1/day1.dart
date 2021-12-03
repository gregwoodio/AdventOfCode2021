import "dart:core";
import "dart:io";

void main() async {
    String input = await File("./day1_input.txt").readAsString();
    List<int> numbers = [];
    var nums = input.split("\n");

    for (var n in nums) {
        numbers.add(int.parse(n));
    }

    print("Part one: ${partOne(numbers)}");
    print("Part two: ${partTwo(numbers)}");
}

int partOne(List<int> input) {
    var count = 0;

    for(var i = 0; i < input.length - 1; i++) {
        if (input[i] < input[i+1]) {
            count++;
        }
    }

    return count;
}

int partTwo(List<int> input) {
    var count = 0;

    for(var i = 0; i < input.length - 3; i++) {
        if (input[i] < input[i+3]) {
            count++;
        }
    }

    return count;
}