import { readFileSync } from 'fs';

export function partOne(input: string[]) {
    let map = {};
    input.forEach(line => {
        let [p1, p2] = line.split(' -> ');
        let [x1, y1] = p1.split(',').map(val => parseInt(val));
        let [x2, y2] = p2.split(',').map(val => parseInt(val));

        if (x1 == x2) {
            let minY = Math.min(y1, y2);
            let maxY = Math.max(y1, y2);

            for (let i = minY; i <= maxY; i++) {
                let key = `${x1},${i}`;
                if (map.hasOwnProperty(key)) {
                    let val = map[key] + 1;
                    map[key] = val;
                } else {
                    map[key] = 1;
                }
            }
        } else if (y1 == y2) {
            let minX = Math.min(x1, x2);
            let maxX = Math.max(x1, x2);

            for (let i = minX; i <= maxX; i++) {
                let key = `${i},${y1}`;
                if (map.hasOwnProperty(key)) {
                    let val = map[key] + 1;
                    map[key] = val;
                } else {
                    map[key] = 1;
                }
            }
        }
    });

    // console.log(map);

    let sum = 0;
    for (const [_, value] of Object.entries(map)) {
        if (value >= 2) {
            sum++;
        }
    }

    return sum;
}


export function solve() {
    let input = readFileSync('./day5_input.txt', 'utf-8').split('\r\n');
    // let input = readFileSync('./day5_sample_input.txt', 'utf-8').split('\r\n');

    console.log(partOne(input));
    // console.log(partTwo(input));
}

solve();