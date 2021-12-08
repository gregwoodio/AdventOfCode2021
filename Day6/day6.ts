import { readFileSync } from 'fs';

export function solvePartOne(input: number[]): number {
    for (let day = 1; day <= 80; day++) {
        let newArr: number[] = [];
        input.forEach((_, i) => {
            input[i]--;
            if (input[i] == -1) {
                input[i] = 6;
                newArr.push(8);
            }
        });
        input = input.concat(newArr);
    }

    return input.length;
}

export function solvePartTwo(input: number[]): number {
    let counts: number[] = [];

    for (let i = 0; i <= 8; i++) {
        counts.push(input.filter(n => n == i).length);
    }

    for (let day = 1; day <= 256; day++) {
        let pop = counts.splice(0, 1)[0];
        counts[6] += pop;
        counts.push(pop);
    }

    let sum = counts.reduce((sum, curr) => sum + curr);
    return sum;
}

function solve() {
    let input = readFileSync('./day6_input.txt', 'utf-8').split(',').map(val => parseInt(val));
    console.log('Part one: ', solvePartOne([...input]));
    console.log('Part two: ', solvePartTwo([...input]));
}

solve();