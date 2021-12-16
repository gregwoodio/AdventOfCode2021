import 'package:test/test.dart';

import 'day16.dart';

class TestData {
  String description;
  String input;
  int expected;

  TestData(this.description, this.input, this.expected);
}

void main() {
  group('day 16 packet parsing tests', () {
    List<TestData> testData = [
      TestData('literal value packet', 'D2FE28', 6),
      TestData('operator packet with length of bits', '38006F45291200', 9),
      TestData('operator packet with number of packets defined',
          'EE00D40C823060', 14),
      TestData('nested operator packet', '8A004A801A8002F478', 16),
      TestData(
          'operator packet with operator packets that contain literal values',
          '620080001611562C8802118E34',
          12),
      TestData('operator packet with different length type ID',
          'C0015000016115A2E0802F182340', 23),
      TestData('triple nested operator packet with 5 literal values',
          'A0016C880162017C3686B18A3D4780', 31)
    ];

    for (var td in testData) {
      test(td.description, () {
        var actual = partOne(td.input);
        expect(actual, equals(td.expected));
      });
    }
  });

  group('day 16 packet operation tests', () {
    List<TestData> testData = [
      TestData('sum packet', 'C200B40A82', 3),
      TestData('product packet', '04005AC33890', 54),
      TestData('min packet', '880086C3E88112', 7),
      TestData('max packet', 'CE00C43D881120', 9),
      TestData('less than packet', 'D8005AC2A8F0', 1),
      TestData('greater than packet', 'F600BC2D8F', 0),
      TestData('equal to packet', '9C005AC2F8F0', 0),
      TestData('larger equal to packet', '9C0141080250320F1802104A08', 1),
    ];

    for (var td in testData) {
      test(td.description, () {
        var actual = partTwo(td.input);
        expect(actual, equals(td.expected));
      });
    }
  });
}
