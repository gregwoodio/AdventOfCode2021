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

export function partTwo(input: string[]) {
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
        } else {
            let xDir = 1;
            if (x1 > x2) {
                xDir = -1;
            }
            let yDir = 1;
            if (y1 > y2) {
                yDir = -1;
            }

            for (let x = x1, y = y1; true; x += xDir, y += yDir) {
                let key = `${x},${y}`;
                if (map.hasOwnProperty(key)) {
                    let val = map[key] + 1;
                    map[key] = val;
                } else {
                    map[key] = 1;
                }

                if (x == x2 && y == y2) {
                    break;
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
    // let input = [];
    // input.push('1,1 -> 3,3');
    // input.push('9,7 -> 7,9');

    console.log(partOne(input));
    console.log(partTwo(input));
}

solve();