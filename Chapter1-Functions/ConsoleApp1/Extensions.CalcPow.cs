using System.Numerics;

namespace ConsoleApp1
{
    public static partial class Extensions
    {
        private static BigInteger Square(this BigInteger target) => target * target;

        //public static BigInteger Pow(BigInteger b, uint n) => Extensions.PowRecursive(b, n);
        public static BigInteger Pow(BigInteger b, uint n) => Extensions.PowIterative(1, b, n);

        // Section 1.2.4
        private static BigInteger PowRecursive(BigInteger b, uint n)
        {
            if (n == 0)
            {
                return 1;
            }

            return n % 2 == 0 
                ? Extensions.PowRecursive(b, n / 2).Square()
                : b * Extensions.PowRecursive(b, n - 1);
        }

        // Exercise 1.17
        private static BigInteger PowIterative(BigInteger a, BigInteger b, uint n)
        {
            if (n == 0)
            {
                return a;
            }

            return n % 2 == 0
                ? Extensions.PowIterative(a, b.Square(), n / 2)
                : Extensions.PowIterative(a * b, b, n - 1);
        }
    }
}
