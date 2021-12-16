import 'dart:io';

void main(List<String> arguments) {
  var input =
      File("${Directory.current.path}\\bin\\day16_input.txt").readAsLinesSync();

  print(partOne(input[0]));
  print(partTwo(input[0]));
}

int partOne(String input) {
  var binary = toBinaryString(input);
  var packet = readPacket(binary);

  var versionSum = sum(packet);
  return versionSum;
}

int partTwo(String input) {
  var binary = toBinaryString(input);
  var packet = readPacket(binary);

  return calculatePacket(packet);
}

class Packet {
  int version;
  int type;
  int lastReadIndex;

  Packet(this.version, this.type, this.lastReadIndex);
}

class LiteralPacket extends Packet {
  int value;

  LiteralPacket(version, type, lastReadIndex, this.value)
      : super(version, type, lastReadIndex);
}

class OperatorPacket extends Packet {
  List<Packet> packets = [];

  OperatorPacket(version, type, lastReadIndex)
      : super(version, type, lastReadIndex);
}

Packet readPacket(String binary) {
  var version = int.parse(binary.substring(0, 3), radix: 2);

  var type = int.parse(binary.substring(3, 6), radix: 2);

  if (type == 4) {
    // literal valued packet
    var binValue = StringBuffer();
    var index = 6;
    while (binary[index] == '1') {
      index++;
      binValue.write(binary.substring(index, index + 4));
      index += 4;
    }

    index++;
    binValue.write(binary.substring(index, index + 4));
    index += 4;

    var value = int.parse(binValue.toString(), radix: 2);
    return LiteralPacket(version, type, index, value);
  } else {
    // operator packet
    if (binary[6] == '0') {
      // next 15 bytes are the total length in bits
      var readBytes = int.parse(binary.substring(7, 7 + 15), radix: 2);
      var sum = version;
      var readTo = readBytes + 22;
      var index = 22;
      var packet = OperatorPacket(version, type, index);

      while (index < readTo) {
        packet.packets.add(readPacket(binary.substring(index)));
        index += packet.packets.last.lastReadIndex;
      }

      packet.lastReadIndex = index;
      return packet;
    } else {
      // total length in packets
      var readPackets = int.parse(binary.substring(7, 7 + 11), radix: 2);
      var packet = OperatorPacket(version, type, 0);
      // var res = Packet(0, 0);
      var index = 18;

      for (var read = 0; read < readPackets; read++) {
        var next = readPacket(binary.substring(index));
        index += next.lastReadIndex;
        packet.packets.add(next);
      }

      packet.lastReadIndex += index;
      return packet;
    }
  }
}

// Larger examples run into handleFormatError when trying to
// parse to int and then to binary string.
String toBinaryString(String hex) {
  var buffer = StringBuffer();
  for (var i = 0; i < hex.length; i++) {
    switch (hex[i]) {
      case '0':
        buffer.write('0000');
        break;
      case '1':
        buffer.write('0001');
        break;
      case '2':
        buffer.write('0010');
        break;
      case '3':
        buffer.write('0011');
        break;
      case '4':
        buffer.write('0100');
        break;
      case '5':
        buffer.write('0101');
        break;
      case '6':
        buffer.write('0110');
        break;
      case '7':
        buffer.write('0111');
        break;
      case '8':
        buffer.write('1000');
        break;
      case '9':
        buffer.write('1001');
        break;
      case 'A':
        buffer.write('1010');
        break;
      case 'B':
        buffer.write('1011');
        break;
      case 'C':
        buffer.write('1100');
        break;
      case 'D':
        buffer.write('1101');
        break;
      case 'E':
        buffer.write('1110');
        break;
      case 'F':
        buffer.write('1111');
        break;
    }
  }

  return buffer.toString();
}

int sum(Packet packet) {
  if (packet.runtimeType == OperatorPacket) {
    var operator = packet as OperatorPacket;
    var mySum = 0;
    for (var p in operator.packets) {
      mySum += sum(p);
    }

    return operator.version + mySum;
  }

  var value = packet as LiteralPacket;
  return value.version;
}

int calculatePacket(Packet packet) {
  if (packet.runtimeType == LiteralPacket) {
    return (packet as LiteralPacket).value;
  }

  var oper = packet as OperatorPacket;

  if (oper.type == 0) {
    // sum packet
    var sum = 0;
    for (var p in oper.packets) {
      sum += calculatePacket(p);
    }
    return sum;
  }

  if (oper.type == 1) {
    // product packet
    var prod = calculatePacket(oper.packets.first);
    for (var i = 1; i < oper.packets.length; i++) {
      prod *= calculatePacket(oper.packets[i]);
    }
    return prod;
  }

  if (oper.type == 2) {
    // min packet
    var values = oper.packets.map((p) => calculatePacket(p));
    var min = 9999999;
    for (var value in values) {
      if (value < min) {
        min = value;
      }
    }
    return min;
  }

  if (oper.type == 3) {
    // max packet
    var values = oper.packets.map((p) => calculatePacket(p));
    var max = -9999999;
    for (var value in values) {
      if (value > max) {
        max = value;
      }
    }
    return max;
  }

  if (oper.type == 5) {
    // greater than
    var values = oper.packets.map((p) => calculatePacket(p)).toList();
    return values[0] > values[1] ? 1 : 0;
  }

  if (oper.type == 6) {
    // less than
    var values = oper.packets.map((p) => calculatePacket(p)).toList();
    return values[0] < values[1] ? 1 : 0;
  }

  if (oper.type == 7) {
    // equal to
    var values = oper.packets.map((p) => calculatePacket(p)).toList();
    return values[0] == values[1] ? 1 : 0;
  }

  // shouldn't get here
  return -1;
}
