import { readFileSync } from 'fs';

class Square {
    value: number;
    marked: boolean = false;

    constructor(value) {
        this.value = value;
    }
}

type Board = {
    squares: Square[][];
}

export function partOne(input: string[]): number {
    let { numbers, boards, squareMap } = parseInput(input);

    // console.log(squareMap);

    for (let i = 0; i < numbers.length; i++) {
        let num = numbers[i];
    // numbers.forEach((num, i) => {
        // console.log(num);
        // console.log(squareMap.get(`${num}`));
        let squares = squareMap.get(`${num}`);
        for (let j = 0; j < squares.length; j++) {
            squares[j].marked = true;
        // squares.forEach(sq => {
            // sq.marked = true;
        // });
        }
        squareMap.set(`${num}`, squares);

        if (i > 5) {
            let score = checkWin(boards, num);
            if (score != -1) {
                console.log(score);
                return score;
            }
        }
    // });
    }
    
    return -1;
}

function parseInput(input: string[]): { numbers: number[], boards: Board[], squareMap: Map<string, Square[]> } {
    let numbers = input[0].split(',').map(val => parseInt(val));
    let boards: Board[] = [];
    let squareMap = new Map<string, Square[]>();

    for (let i = 2; i < input.length; i += 6) {
        let squares: Square[][] = [];
        for (let j = i; j < i + 5; j++) {
            let row = input[j].trim().replace(/ +/g, '_').split('_').map(val => new Square(val));
            row.forEach(square => {
                if (squareMap.has(`${square.value}`)) {
                    squareMap.set(`${square.value}`, [...squareMap.get(`${square.value}`), square]);
                } else {
                    squareMap.set(`${square.value}`, [square]);
                }
            });

            squares.push(row);
        }

        boards.push({
            squares: squares
        });
    }

    // console.log('boards count: ', boards.length);

    return { numbers, boards, squareMap };
}

function checkWin(boards: Board[], lastCalled: number): number {
    console.log(boards);
    boards.forEach(board => {
        // check rows
        for (let i = 0; i < board.squares.length; i++) {
            let win = true
            for (let j = 0; j < board.squares[i].length; j++) {
                if (!board.squares[i][j].value) {
                    win = false;
                }
            }

            if (win) {
                // console.log('found winning board: ', board);
                return getScore(board, lastCalled);
            }
        }

        // check columns
        for (let i = 0; i < board.squares.length; i++) {
            let win = true
            for (let j = 0; j < board.squares[i].length; j++) {
                if (!board.squares[j][i].value) {
                    win = false;
                }
            }

            if (win) {
                // console.log('found winning board: ', board);
                return getScore(board, lastCalled);
            }
        }
    });

    return -1;
}

function getScore(board: Board, lastCalled: number): number {
    // let score = board.squares
    //     .flatMap(sq => sq)
    //     .filter(sq => !sq.marked)
    //     .map(sq => sq.value)
    //     .reduce((sum, val) => sum += val, 0) * lastCalled;
    let unmarkedSquares = board.squares.flatMap(sq => sq).filter(sq => !sq.marked);
    console.log('unmarkedsquares: ', unmarkedSquares);
    let sum = unmarkedSquares.map(sq => sq.value).reduce((sum, val) => sum += val, 0);
    console.log('sum: ', sum);
    console.log('lastCalled: ', lastCalled);
    let score = sum * lastCalled;

    console.log(score);
    return score;
}

export function solve() {
    let input = readFileSync('./day4_sample_input.txt', 'utf-8').split('\r\n');

    console.log(partOne(input));
    // console.log(partTwo(input));
}

solve();