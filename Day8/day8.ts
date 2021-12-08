import { readFileSync } from 'fs';

export function partOne(input: string[]): number {
    let count = 0;
    input.forEach(line => {
        let parts = line.split('|');
        let output = parts[1];

        let segments = output.split(' ');
        count += segments.filter(segment => segment.length == 2 || segment.length == 3 || segment.length == 4 || segment.length == 7).length;
    });

    return count;
}

//  aaa  This config would be ['a','b','c','d','e','f','g'] (order matters)
// b   c
// b   c
// b   c
//  ddd
// e   f
// e   f
// e   f
//  ggg
export function partTwo(input: string[]): number {
    let sum = 0;

    input.forEach(line => {
        let [inputs, outputs] = line.split('|');

        // sort inputs alphabetically
        let nums = inputs.trim().split(' ');
        nums = nums.map(val => val.split('').sort(s).join(''));

        let segments: string[] = [null, null, null, null, null, null, null];

        // find one and seven. The unmatched segment from 7 is the first (a) segment.
        let one = nums.filter(n => n.length == 2)[0];
        let seven = nums.filter(n => n.length == 3)[0];
        segments[0] = seven.split('').filter(v => !one.split('').includes(v))[0];

        // find four. It will have two segments that don't match one.
        let four = nums.filter(n => n.length == 4)[0];
        let fourUnmatched = four.split('').filter(v => !one.split('').includes(v));

        // find 6 digit numbers (will be 0, 6 or 9). The one that does not include
        // both fourUnmatched parts is 0.
        let sixDigitNums = nums.filter(n => n.length == 6);
        let zero = sixDigitNums.filter(num => {
            let parts = num.split('');
            let arr = parts.filter(x => !fourUnmatched.includes(x));
            return arr.length == 5;
        })[0];
        segments[3] = fourUnmatched.filter(x => !zero.split('').includes(x))[0];
        segments[1] = fourUnmatched.filter(x => x != segments[3])[0];

        // Nine will contain all values from one, which also reveals six. Nine is missing
        // the 4th index (e), and six is missing the 2nd index (c).
        sixDigitNums = sixDigitNums.filter(x => x != zero);
        let nine = sixDigitNums.filter(six => {
            let parts = six.split('');
            let arr = parts.filter(x => !one.split('').includes(x));
            return arr.length == 4;
        })[0];
        let six = sixDigitNums.filter(x => x != nine)[0];

        let eight = 'abcdefg';
        segments[4] = eight.split('').filter(x => !nine.split('').includes(x))[0];
        segments[2] = eight.split('').filter(x => !six.split('').includes(x))[0];
        segments[5] = one.split('').filter(x => x != segments[2])[0];
        segments[6] = eight.split('').filter(x => !segments.includes(x))[0];

        let two = [segments[0], segments[2], segments[3], segments[4], segments[6]].sort(s).join('');
        let three = [segments[0], segments[2], segments[3], segments[5], segments[6]].sort(s).join('');
        let five = [segments[0], segments[1], segments[3], segments[5], segments[6]].sort(s).join('');

        let outNums = outputs.split(' ').map(x => x.split('').sort(s).join(''));
        let curr: number = 0;
        if (outNums[0] == zero) {
            curr = 0;
        } else if (outNums[0] == one) {
            curr = 1;
        } else if (outNums[0] == two) {
            curr = 2;
        } else if (outNums[0] == three) {
            curr = 3;
        } else if (outNums[0] == four) {
            curr = 4;
        } else if (outNums[0] == five) {
            curr = 5;
        } else if (outNums[0] == six) {
            curr = 6;
        } else if (outNums[0] == seven) {
            curr = 7;
        } else if (outNums[0] == eight) {
            curr = 8;
        } else if (outNums[0] == nine) {
            curr = 9;
        }
        
        for (let i = 1; i < outNums.length; i++) {
            curr *= 10;

            if (outNums[i] == zero) {
                curr += 0;
            } else if (outNums[i] == one) {
                curr += 1;
            } else if (outNums[i] == two) {
                curr += 2;
            } else if (outNums[i] == three) {
                curr += 3;
            } else if (outNums[i] == four) {
                curr += 4;
            } else if (outNums[i] == five) {
                curr += 5;
            } else if (outNums[i] == six) {
                curr += 6;
            } else if (outNums[i] == seven) {
                curr += 7;
            } else if (outNums[i] == eight) {
                curr += 8;
            } else if (outNums[i] == nine) {
                curr += 9;
            }
        }

        sum += curr;
    });

    return sum;
}

function solve() {
    let input = readFileSync('./day8_input.txt', 'utf-8').split('\r\n');

    console.log('Part one: ', partOne(input));
    console.log('Part two: ', partTwo(input));
}

function s(x: string, y: string): number {
    return x > y ? 1 : -1;
}

solve();