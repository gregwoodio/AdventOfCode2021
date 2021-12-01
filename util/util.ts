import { promisify } from 'util';
import { readFile } from 'fs';

const readFilePromise = promisify(readFile);

export function readIntsFromFile(filepath: string): number[] {
    let numbers: number[] = [];

    readFilePromise(filepath, 'utf-8')
        .then(data => data.split(/r?\n/).forEach(num => numbers.push(parseInt(num))))
        .catch(err => console.error(err));

    return numbers;
}