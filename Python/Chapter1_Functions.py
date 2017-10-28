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

# 1.2.1
def factorial_r(n):
    # calc n! by recursive-process.
    if (n == 1):
        return 1
    else:
        return n * factorial_r(n - 1)

factorial_r(6)

def factorial_i(n):
    # calc n! by iterative-process.
    def fact_iter(product, count):
        if (count > n):
            return product
        else:
            return fact_iter(count * product, count + 1)
    return fact_iter(1, 1)

factorial_i(6)

# 1.2.2
def fib_ugry(n):
    if (n == 0):
        return 0
    elif (n == 1):
        return 1
    else:
        return fib_ugry(n - 1) + fib_ugry(n - 2)

fib_ugry(10)

def fib(n):
    def fib_iter(a, b, count):
        if (count == 0):
            return b
        else:
            return fib_iter(a + b, a, count - 1)
    return fib_iter(1, 0, n)

fib(10)

def count_change(amount):
    def cc(amount, kinds_of_coins):
        if (amount == 0):
            return 1
        elif (amount < 0) or (kinds_of_coins == 0):
            return 0
        else:
            return cc(amount, kinds_of_coins - 1) \
                 + cc(amount - first_denomination(kinds_of_coins), 
                    kinds_of_coins)
    def first_denomination(kinds_of_coins):
        if (kinds_of_coins == 1):
            return 1
        elif (kinds_of_coins == 2):
            return 5
        elif (kinds_of_coins == 3):
            return 10
        elif (kinds_of_coins == 4):
            return 25
        elif (kinds_of_coins == 5):
            return 50
    return cc(amount, 5)

count_change(100)

# ex.1.11
def ex11_r(n):
    if (n < 3):
        return n
    else:
        return ex11_r(n - 1) + 2 * ex11_r(n - 2) + 3 * ex11_r(n - 3)

ex11_r(3) # 1*2 + 2*1 + 3*0 = 4
ex11_r(4) # 1*4 + 2*2 + 3*1 = 11
ex11_r(5) # 1*11 + 2*4 + 3*2 = 25

def ex11_i(n):
    def ex11_iter(v1, v2, v3, count):
        if (count < 3):
            return v1
        else:
            return ex11_iter(1*v1 + 2*v2 + 3*v3, v1, v2, (count - 1))
    if (n < 3):
        return n
    else:
        return ex11_iter(2, 1, 0, n)

[ex11_i(n) for n in range(10)]
# [0, 1, 2, 4, 11, 25, 59, 142, 335, 796]

# ex.1.12
def pascal(n, k):
    # calc Pascal's Triangle element of n-th row, k-th column
    if (n == 1 or k == 1 or n == k):
        return 1
    else:
        return pascal(n - 1, k - 1) + pascal(n - 1, k)

[[pascal(n, k) for k in range(1, n + 1)] for n in range(1, 8 + 1)]

# ex.1.15
def cube(x):
    return x * x * x

def sine(angle):
    def p(x):
        print('p: ', angle)
        return (3*x - 4*cube(x))
    if (not (abs(angle) > 0.1)):
        return angle
    else:
        return p(sine(angle / 3.0))

sine(12.15)

# 1.2.4
def expt_r(base, n):
    if (n == 0):
        return 1
    else:
        return base * expt_r(base, n-1)

def expt_i(base, n):
    def expt_iter(base, counter, product):
        if (counter == 0):
            return product
        else:
            return expt_iter(base, counter - 1, base * product)
    return expt_iter(base, n, 1)

expt_r(2, 10)
expt_i(2, 10)

def is_even(n):
    return n % 2 == 0

def fast_expt_r(base, n):
    if (n == 0):
        return 1
    elif is_even(n):
        return square(fast_expt_r(base, n / 2))
    else:
        return base * fast_expt_r(base, n - 1)

fast_expt_r(2, 10)

# ex.1.16
def fast_expt_i(base, n):
    def expt_iter(base, n, result):
        if (n == 0):
            return result
        elif is_even(n):
            return expt_iter(square(base), n / 2, result)
        else:
            return expt_iter(base, n - 1, base * result)
    return expt_iter(base, n, 1)

fast_expt_i(2, 10)
fast_expt_i(2, 100)

# ex.1.17
def double(n):
    return n + n
def halve(n):
    return n / 2

def mult_r(a, b):
    if (b == 0):
        return 0
    elif is_even(b):
        return double(mult_r(a, halve(b)))
    else:
        return a + mult_r(a, b - 1)

mult_r(7, 143)

# ex.1.18
def mult_i(a, b):
    def mult_iter(base, n, result):
        if (n == 0):
            return result
        elif is_even(n):
            return mult_iter(double(base), halve(n), result)
        else:
            return mult_iter(base, n - 1, base + result)
    return mult_iter(a, b, 0)

mult_i(7, 143)
