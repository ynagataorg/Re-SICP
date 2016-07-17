using System;
using static System.Math;

namespace ConsoleApp1
{
    public static class Extensions
    {
        public static decimal Square(decimal target)
        {
            return target * target;
        }

        // Section 1.1.7:
        public static decimal MySqrt(decimal target)
        {
            //return MySqrtIter(1m, target);
            return MySqrtIter2(1m, 1m / target, target);
        }

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
    }
}