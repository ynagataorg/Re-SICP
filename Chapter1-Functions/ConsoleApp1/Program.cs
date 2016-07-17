using System;

namespace ConsoleApp1
{
    internal class Program
    {
        private static void Main(string[] args)
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
    }
}
