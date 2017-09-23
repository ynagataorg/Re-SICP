namespace ConsoleApp1
{
    public static partial class Extensions
    {
        public static uint Fib(uint n)
            => FibIterative(1, 0, n);

        private static uint FibRecursive(uint n)
            => n == 0
                ? 0
                : n == 1
                    ? 1
                    : FibRecursive(n - 1) + FibRecursive(n - 2);

        private static uint FibIterative(uint prev1, uint prev2, uint count)
            => count == 0
                ? prev2
                : FibIterative(prev1 + prev2, prev1, count - 1);
    }
}
