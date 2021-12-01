export function partOne(numbers: number[]): number {
    let prev = numbers.shift();
    let higher = 0;
    numbers.reduce((prev, curr) => {
        if (prev < curr) {
            higher++;
        }
        return curr;
    }, prev);

    return higher;
}

export function partTwo(numbers: number[]): number {
    let higher = 0;

    for (let i = 0; i < numbers.length - 3; i++) {
        let group1 = numbers[i] + numbers[i+1] + numbers[i+2];
        let group2 = numbers[i+1] + numbers[i+2] + numbers[i+3];

        if (group1 < group2) {
            higher++;
        }
    }

    return higher;
}