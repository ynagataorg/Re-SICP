using System;
using static System.Math;

namespace ConsoleApp1
{
    public static partial class Extensions
    {
        public static decimal Square(this decimal target)
            => target * target;

        // Section 1.1.7:
        public static decimal MySqrt(this decimal target)
            => MySqrtIter2(1m, 1m / target, target);

        public static decimal Cube(this decimal target)
            => target * target * target;

        // Exercise 1.8:
        public static decimal MyCbrt(this decimal target)
            => MyCbrtIter(1m, 1m / target, target);

        // Section 1.1.7:
        private static decimal MySqrtIter(decimal guessValue, decimal target)
        {
            Func<decimal, decimal, bool> goodEnough = (guess, x) => Abs(guess * guess - x) < 1e-10m;
            Func<decimal, decimal, decimal> improve = (guess, x) => (guess + (x / guess)) / 2;
            return goodEnough(guessValue, target)
                ? guessValue
                : MySqrtIter(improve(guessValue, target), target);
        }

        // Exercise 1.7:
        private static decimal MySqrtIter2(decimal guessValue, decimal oldGuessValue, decimal target)
        {
            Func<decimal, decimal, bool> goodEnough = (guess, oldGuess) => Abs(guess - oldGuess) / guess < 1e-10m;
            Func<decimal, decimal, decimal> improve = (guess, x) => (guess + (x / guess)) / 2;
            return goodEnough(guessValue, oldGuessValue)
                ? guessValue
                : MySqrtIter2(improve(guessValue, target), guessValue, target);
        }

        // Exercise 1.8:
        private static decimal MyCbrtIter(decimal guessValue, decimal oldGuessValue, decimal target)
        {
            Func<decimal, decimal, bool> goodEnough = (guess, oldGuess) => Abs(guess - oldGuess) / guess < 1e-10m;
            Func<decimal, decimal, decimal> improve = (guess, x) => (2 * guess + x / Square(guess)) / 3;
            return goodEnough(guessValue, oldGuessValue)
                ? guessValue
                : MyCbrtIter(improve(guessValue, target), guessValue, target);
        }
    }
}