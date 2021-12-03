import { readFileSync } from 'fs';

export function partOne(numbers: string[]): number {
    console.log('First: ', numbers[0]);
    console.log(' Length: ', numbers[0].length);
    let counts = new Array<number>(numbers[0].length).fill(0);

    numbers.forEach(num => {
        for (let i = 0; i < num.length; i++) {
            if (num[i] == '1') {
                counts[i]++;
            }
        }

    });

    let gamma = counts.map(count => count > numbers.length / 2 ? '1' : '0').join(''); // more common bit 
    let epsilon = counts.map(count => count < numbers.length / 2 ? '1' : '0').join(''); // less common bit

    counts.forEach((count, i) => {
        console.log(`index: ${i} ones: ${count} zeros: ${numbers.length - count}`);
    });

    console.log('gamma: ', gamma);
    console.log('epsilon: ', epsilon);

    let g = parseInt(gamma, 2);
    let e = parseInt(epsilon, 2);

    return g * e;
}

export function solve() {
    let input = readFileSync('./day3_input.txt', 'utf-8').split('\r\n');

    console.log(partOne(input));
}

solve();