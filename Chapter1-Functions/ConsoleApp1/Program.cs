using System;
using System.Linq;

namespace ConsoleApp1
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            //foreach (var ii in Enumerable.Range(0, 10))
            //{
            //    foreach (var jj in Enumerable.Range(0, ii + 1))
            //    {
            //        Console.Write($"{Extensions.PascalRecursive(ii, jj)} ");
            //    }
            //    Console.WriteLine();
            //}

            Console.WriteLine($"2^    10 = {2.Pow(10):#,0}");
            Console.WriteLine($"2^    20 = {2.Pow(20):#,0}");
            Console.WriteLine($"2^   100 = {2.Pow(100):#,0}");
            Console.WriteLine($"2^  1000 = {2.Pow(1000):#,0}");
            Console.WriteLine($"2^ 10000 = {2.Pow(10000):#,0}");
            //Console.WriteLine($"2^100000 = {2.Pow(100000):#,0}");

            foreach (var ii in Enumerable.Range(1, 100))
            {
                Console.WriteLine($"2^{ii} = {2.Pow((uint)ii):#,0}");
            }
        }

        private static void TryMySqrt()
        {
            var targets = new[] { 2m, 3m, 5m, 1e-10m, 1e-20m, 1e10m, 1e16m };
            foreach (var target in targets)
            {
                var sqrt = target.MySqrt();
                Console.WriteLine($"MySqrt({target}) = {sqrt}");
                Console.WriteLine($"Square(MySqrt({target})) = {sqrt.Square()}");
                Console.WriteLine($"Error: {Math.Abs(sqrt.Square() - target)}");
                Console.WriteLine();
            }
        }

        private static void TryMyCbrt()
        {
            var targets = new[] { 2m, 8m, 27m, 1e-12m, 1e-21m, 1e9m, 1e12m };
            foreach (var target in targets)
            {
                var cbrt = target.MyCbrt();
                Console.WriteLine($"MyCbrt({target}) = {cbrt}");
                Console.WriteLine($"Cube(MyCbrt({target})) = {cbrt.Cube()}");
                Console.WriteLine($"Error: {Math.Abs(cbrt.Cube() - target)}");
                Console.WriteLine();
            }
        }

        private static void TryMyFact()
        {
            var targets = new uint[] { 0, 1, 2, 3, 4, 5, 6 };
            foreach (var target in targets)
            {
                Console.WriteLine($"Factorial({target}) = {Extensions.FactorialRecursive(target)}");
                Console.WriteLine($"Factorial2({target}) = {Extensions.Factorial(target)}");
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