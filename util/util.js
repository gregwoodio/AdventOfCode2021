import { promisify } from 'util';
import { readFileSync } from 'fs';

const readFilePromise = promisify(readFile);

function readIntsFromFile(filepath) {
    let numbers = [];

    let data = readFileSync(filepath);
    data.split(/r?\n/).forEach(num => {
        console.log(num);
        numbers.push(parseInt(num));
    });

    return numbers;
}

module.exports = [
    readIntsFromFile
];