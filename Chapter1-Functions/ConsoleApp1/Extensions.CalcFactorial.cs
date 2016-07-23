namespace ConsoleApp1
{
    public static partial class Extensions
    {
        public static uint Ackermann(uint m, uint n)
        {
            if (n == 0)
            {
                return 0;
            }
            if (m == 0)
            {
                return 2 * n;
            }
            if (n == 1)
            {
                return 2;
            }

            return Ackermann(m - 1, Ackermann(m, n - 1));
        }

        public static uint Factorial(uint n)
            => FactorialIterative(1, 1, n);


        public static uint FactorialRecursive(uint n)
            => n == 0
                ? 1
                : n * FactorialRecursive(n - 1);

        private static uint FactorialIterative(uint product, uint count, uint maxCount)
            => (count > maxCount)
                ? product
                : FactorialIterative(count * product, count + 1, maxCount);
    }
}