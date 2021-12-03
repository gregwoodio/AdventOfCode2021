import { partOne, partTwo } from "./day3";

describe('Day 3', () => {
    const input = [
            '00100',
            '11110',
            '10110',
            '10111',
            '10101',
            '01111',
            '00111',
            '11100',
            '10000',
            '11001',
            '00010',
            '01010',
        ];

    it('part 1', () => {
        let expected = 198;
        let actual = partOne(input);
        expect(expected).toBe(actual);
    });

    it('part 2', () => {
        let expected = 230;
        let actual = partTwo(input);
        expect(expected).toBe(actual);
    });
});