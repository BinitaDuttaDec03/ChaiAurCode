class ArrayUtils {
    static boolean checkEmpty(int[] numbers) {
        return numbers.length == 0;
    }

    static int sum(int[] numbers) {
        // TODO
        if (checkEmpty(numbers))
            return 0;

        int sum = 0;

        for (int num : numbers)
            sum += num;

        return sum;
    }

    static int max(int[] numbers) {
        // TODO: throw IllegalArgumentException for an empty array
        if (checkEmpty(numbers))
            throw new IllegalArgumentException("Array is empty");

        int max = numbers[0];

        for (int num : numbers)
            max = Math.max(max, num);

        return max;
    }

    static double average(int[] numbers) {
        if (checkEmpty(numbers))
            return 0.0;

        // TODO
        double sum = 0;

        for (int num : numbers)
            sum += num;

        return sum / numbers.length;
    }

    static int countVowels(String text) {
        if (text == null)
            return 0;

        // TODO: ignore case, return 0 for null
        text = text.toLowerCase();
        int count = 0;

        for (int i = 0; i < text.length(); i++) {
            if (text.charAt(i) == 'a' || text.charAt(i) == 'e' || text.charAt(i) == 'i' || text.charAt(i) == 'o'
                    || text.charAt(i) == 'u')
                count++;
        }

        return count;
    }
}
