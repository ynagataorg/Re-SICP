using System;

namespace ConsoleApp1
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            TryMySqrt();
            TryMyCbrt();
        }

        private static void TryMySqrt()
        {
            var targets = new[] {2m, 3m, 5m, 1e-10m, 1e-20m, 1e10m, 1e16m};
            foreach (var target in targets)
            {
                var sqrt = Extensions.MySqrt(target);
                Console.WriteLine($"MySqrt({target}) = {sqrt}");
                Console.WriteLine($"Square(MySqrt({target})) = {Extensions.Square(sqrt)}");
                Console.WriteLine($"Error: {Math.Abs(Extensions.Square(sqrt) - target)}");
                Console.WriteLine();
            }
        }

        private static void TryMyCbrt()
        {
            var targets = new[] { 2m, 8m, 27m, 1e-12m, 1e-21m, 1e9m, 1e12m };
            foreach (var target in targets)
            {
                var cbrt = Extensions.MyCbrt(target);
                Console.WriteLine($"MyCbrt({target}) = {cbrt}");
                Console.WriteLine($"Cube(MyCbrt({target})) = {Extensions.Cube(cbrt)}");
                Console.WriteLine($"Error: {Math.Abs(Extensions.Cube(cbrt) - target)}");
                Console.WriteLine();
            }
        }
    }
}
