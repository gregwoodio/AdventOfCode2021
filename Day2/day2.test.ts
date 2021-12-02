import { partOne, partTwo } from "./day2";

describe('Day 2 tests', () => {

    it('part one example', () => {
        let input = [
            'forward 5',
            'down 5',
            'forward 8',
            'up 3',
            'down 8',
            'forward 2',
        ];

        let expected = 150;
        let actual = partOne(input);

        expect(actual).toBe(expected);
    });

    it.only('part two example', () => {
        let input = [
            'forward 5',
            'down 5',
            'forward 8',
            'up 3',
            'down 8',
            'forward 2',
        ];

        let expected = 900;
        let actual = partTwo(input);

        expect(actual).toBe(expected);
    });
});