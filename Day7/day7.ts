import { readFileSync } from 'fs';

export function partOne(input: number[]): number {
    input.sort((x, y) => x > y ? 1 : -1);
    let median = input[input.length / 2];

    let sum = 0;
    input.forEach(num => {
        sum += Math.abs(median - num);
    });

    return sum;
}

function solve() {
    let input = readFileSync('./day7_input.txt', 'utf-8').split(',').map(val => parseInt(val));

    console.log(partOne(input));
    // console.log(partTwo(input));
}

solve();