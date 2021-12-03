import { util } from "@aocutil/util";
import { partOne, partTwo } from "./day1";

describe('Day 1', () => {

    it('part one example 1', () => {
        let nums = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
        let expected = 7;

        let actual = partOne(nums);
        expect(actual).toBe(expected);
    });

    it.skip('part one real input', () => {
        let nums = util.readIntsFromFile('./day1_input.txt')

        console.log('*** Answer: ***');
        console.log(partOne(nums));
    });

    it('part 2 example 1', () => {
        let nums = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
        let expected = 5;

        let actual = partTwo(nums);
        expect(actual).toBe(expected);
    });
});