import "dart:core";
import "dart:io";

void main() async {
    String contents = await File("./day2_input.txt").readAsString();
    List<int> numbers = [];
    var input = contents.split("\n");

    print("Part one: ${partOne(input)}");
    print("Part two: ${partTwo(input)}");
}

int partOne(List<String> input) {
    int forward = 0;
    int depth = 0;

    for(String inst in input) {
        List<String> parts = inst.split(" ");
        var value = int.parse(parts[1]);
        if (parts[0] == "forward") {
            forward += value; 
        } else if (parts[0] == "up") {
            depth -= value;
        } else if (parts[0] == "down") {
            depth += value;
        }
    }

    return forward * depth;
}

int partTwo(List<String> input) {
    int forward = 0;
    int depth = 0;
    int aim = 0;

    for(String inst in input) {
        List<String> parts = inst.split(" ");
        var value = int.parse(parts[1]);
        if (parts[0] == "forward") {
            forward += value; 
            depth += aim * value;
        } else if (parts[0] == "up") {
            aim -= value;
        } else if (parts[0] == "down") {
            aim += value;
        }
    }

    return forward * depth;
}