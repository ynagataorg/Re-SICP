using System;
using System.Linq;

namespace ConsoleApp1
{
    internal class Program
    {
        private static void Main(string[] args)
        {
        }

        private static void TryMySqrt()
        {
            var targets = new[] { 2m, 3m, 5m, 1e-10m, 1e-20m, 1e10m, 1e16m };
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

        private static void TryMyFact()
        {
            var targets = new uint[] { 0, 1, 2, 3, 4, 5, 6 };
            foreach (var target in targets)
            {
                Console.WriteLine($"Factorial({target}) = {Extensions.Factorial(target)}");
                Console.WriteLine($"Factorial2({target}) = {Extensions.Factorial2(target)}");
                Console.WriteLine();
            }
        }

        private static void TryAck()
        {
            Console.WriteLine($"Ack(1, 10) = {Extensions.Ackermann(1, 10)}");
            Console.WriteLine($"Ack(2, 4) = {Extensions.Ackermann(2, 4)}");
            Console.WriteLine($"Ack(3, 3) = {Extensions.Ackermann(3, 3)}");

            foreach (var ii in Enumerable.Range(0, 10))
            {
                Console.WriteLine($"Ack(1, {ii}) = {Extensions.Ackermann(1, (uint)ii)}");
            }
            foreach (var ii in Enumerable.Range(0, 5))
            {
                Console.WriteLine($"Ack(2, {ii}) = {Extensions.Ackermann(2, (uint)ii)}");
            }
            foreach (var ii in Enumerable.Range(0, 4))
            {
                Console.WriteLine($"Ack(3, {ii}) = {Extensions.Ackermann(3, (uint)ii)}");
            }
        }
    }
}