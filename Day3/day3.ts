import { readFileSync } from 'fs';

function getGammaAndEpsilon(numbers: string[]): { gamma: string, epsilon: string} {
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

    return { gamma, epsilon };
}

export function partOne(numbers: string[]): number {
    let { gamma, epsilon } = getGammaAndEpsilon(numbers);

    let g = parseInt(gamma, 2);
    let e = parseInt(epsilon, 2);

    return g * e;
}

export function partTwo(numbers: string[]): number {
    let ogr: string[] = [...numbers]; // oxygen generator rating
    let c02: string[] = [...numbers]; // c02 scrubber rating

    while (ogr.length > 1) {
        for (let i = 0; i < ogr[0].length; i++) {
            let count = 0;
            ogr.forEach(val => {
                if (val[i] == '1') {
                    count++;
                }
            });

            let moreCommon = count >= ogr.length / 2 ? '1' : '0';
            ogr = ogr.filter(val => val[i] == moreCommon);

            if (ogr.length == 1) {
                break;
            }
        }
    }

    while (c02.length > 1) {
        for (let i = 0; i < ogr[0].length; i++) {
            let count = 0;
            c02.forEach(val => {
                if (val[i] == '1') {
                    count++;
                }
            });

            let lessCommon = count >= c02.length / 2 ? '0' : '1';
            c02 = c02.filter(val => val[i] == lessCommon);

            if (c02.length == 1) {
                break;
            }
        }
    }

    let o = parseInt(ogr[0], 2);
    let c = parseInt(c02[0], 2);

    return o * c;
}

export function solve() {
    let input = readFileSync('./day3_input.txt', 'utf-8').split('\r\n');

    console.log(partOne(input));
    console.log(partTwo(input));
}

solve();