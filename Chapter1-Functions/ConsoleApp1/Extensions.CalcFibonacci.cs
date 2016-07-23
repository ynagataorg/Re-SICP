//using System;

namespace ConsoleApp1
{
    public static partial class Extensions
    {
        public static uint FibRecursive(uint n)
        {
            //Console.WriteLine($"calc fib{n}.");
            return n == 0
                ? 0
                : n == 1
                    ? 1
                    : FibRecursive(n - 1) + FibRecursive(n - 2);
        }

        public static uint Fib(uint n)
        {
            return FibIterative(1, 0, n);
        }

        private static uint FibIterative(uint prev1, uint prev2, uint count)
        {
            //Console.WriteLine($"calc fib{count}.");
            return count == 0
                ? prev2
                : FibIterative(prev1 + prev2, prev1, count - 1);
        }
    }
}
