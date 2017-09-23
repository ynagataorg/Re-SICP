using System.Numerics;

namespace ConsoleApp1
{
    public static partial class Extensions
    {
        private static BigInteger Square(this BigInteger target)
            => target * target;

        public static BigInteger Pow(this int b, uint n)
            => ((BigInteger)b).Pow(n);

        //public static BigInteger Pow(this BigInteger b, uint n)
        //    => b.PowRecursive(n);
        public static BigInteger Pow(this BigInteger b, uint n)
            => ((BigInteger)1).PowIterative(b, n);

        // Section 1.2.4
        private static BigInteger PowRecursive(this BigInteger b, uint n)
        {
            if (n == 0)
            {
                return 1;
            }

            return n % 2 == 0 
                ? b.PowRecursive(n / 2).Square()
                : b * b.PowRecursive(n - 1);
        }

        // Exercise 1.17
        private static BigInteger PowIterative(this BigInteger a, BigInteger b, uint n)
        {
            if (n == 0)
            {
                return a;
            }

            return n % 2 == 0
                ? a.PowIterative(b.Square(), n / 2)
                : (a * b).PowIterative(b, n - 1);
        }
    }
}
