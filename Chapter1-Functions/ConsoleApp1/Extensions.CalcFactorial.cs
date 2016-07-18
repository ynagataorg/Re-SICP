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
        {
            // linear recursive process.
            return n == 0
                ? 1
                : n * Factorial(n - 1);
        }

        public static uint Factorial2(uint n)
        {
            return FactIter(1, 1, n);
        }

        private static uint FactIter(uint product, uint count, uint maxCount)
        {
            // linear iterative process.
            return (count > maxCount)
                ? product
                : FactIter(count * product, count + 1, maxCount);
        }
    }
}