# 1.1.1
(3 * ((2 * 4) + (3 + 5))) + ((10 - 7) + 6)

# 1.1.2
radius = 10
pi = 3.14159
pi * (radius * radius)

circum = 2 * pi * radius
"""
>>> circum
62.8318
"""

# 1.1.4
def square(x):
    return x * x

square(21)
square(2 + 5)
square(square(3))

def sum_of_squares(x, y):
    return square(x) + square(y)

sum_of_squares(3, 4)

# ex.1.3
def sum_of_squares_from_three_of_two(x, y, z):
    return square(x) + square(y) + square(z) - square(min(x, y, z))

sum_of_squares_from_three_of_two(3, 4, 5)

# 1.1.7, 1.1.8
def my_sqrt(x):
    def is_good_enough(guess, old):
        return abs(guess - old) / guess < 0.001
    def average(x, y):
        return (x + y) / 2
    def improve(guess, x):
        return average(guess, (x / guess))
    def sqrt_iter(guess, old, x):
        if (is_good_enough(guess, old)):
            return guess
        else:
            return sqrt_iter(improve(guess, x), guess, x)
    return sqrt_iter(1.0, x, x)

"""
>>> my_sqrt(2)
1.4142135623746899
>>> my_sqrt(5)
2.2360688956433634
>>> my_sqrt(1e-10)
1.0000000015603234e-05
"""

# ex.1.8
def my_cbrt(x):
    def is_good_enough(guess, old):
        return abs(guess - old) / guess < 0.001
    def average(x, y):
        return (x + y) / 2
    def improve(guess, x):
        return average(guess, (x / guess ** 2 + 2 * guess) / 3)
    def cbrt_iter(guess, old, x):
        if (is_good_enough(guess, old)):
            return guess
        else:
            return cbrt_iter(improve(guess, x), guess, x)
    return cbrt_iter(1.0, x, x)

"""
>>> my_cbrt(27)
3.0018696341051916
>>> my_cbrt(1000)
10.009419213708078
>>> my_cbrt(1e-18)
1.0005872910315646e-06
"""
