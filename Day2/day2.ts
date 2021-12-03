export function partOne(input: string[]): number {
    let depth = 0;
    let forward = 0;
    input.forEach(inst => {
        let parts = inst.split(' ');
        switch (parts[0]) {
            case 'forward':
                forward += parseInt(parts[1]);
                break;
            case 'up':
                depth -= parseInt(parts[1]);
                break;
            case 'down':
                depth += parseInt(parts[1]);
                break;
        }
    });

    return depth * forward;
}

export function partTwo(input: string[]): number {
    let aim = 0;
    let forward = 0;
    let depth = 0;
    input.forEach(inst => {
        let parts = inst.split(' ');
        switch (parts[0]) {
            case 'forward':
                let num = parseInt(parts[1]);
                forward += num;
                depth += aim * num;
                break;
            case 'up':
                aim -= parseInt(parts[1]);
                break;
            case 'down':
                aim += parseInt(parts[1]);
                break;
        }
    });

    return depth * forward;
}