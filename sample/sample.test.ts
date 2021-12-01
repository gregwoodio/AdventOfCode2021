import { User, isAdult } from './sample';

describe('sample test', () => {
    it('isAdult should work', () => {
        const user1: User = {
            name: 'Greg',
            age: 34
        };

        expect(isAdult(user1)).toBe(true);

        const user2: User = {
            name: 'Mabel',
            age: 5
        };

        expect(isAdult(user2)).toBe(false);
    });
});