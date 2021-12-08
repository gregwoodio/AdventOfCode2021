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

export function partTwo(input: number[]): number {
    let average = Math.floor(input.reduce((sum, curr) => sum + curr) / input.length);
    console.log('average:', average);

    let sum = 0;
    input.forEach(num => {
        let mult = 1;
        let diff = Math.abs(average - num);

        while (diff > 0) {
            sum += mult;
            mult++;
            diff--;
        }
    });

    return sum;
}

function solve() {
    let input = readFileSync('./day7_input.txt', 'utf-8').split(',').map(val => parseInt(val));

    console.log('Part one: ', partOne(input));
    console.log('Part two: ', partTwo(input));
}

solve();