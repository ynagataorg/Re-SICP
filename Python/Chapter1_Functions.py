import random

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
    def iter(guess, old, x):
        if (is_good_enough(guess, old)):
            return guess
        else:
            return iter(improve(guess, x), guess, x)
    return iter(1.0, x, x)

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
    def iter(guess, old, x):
        if (is_good_enough(guess, old)):
            return guess
        else:
            return iter(improve(guess, x), guess, x)
    return iter(1.0, x, x)

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
    def iter(product, count):
        if (count > n):
            return product
        else:
            return iter(count * product, count + 1)
    return iter(1, 1)

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
    def iter(a, b, count):
        if (count == 0):
            return b
        else:
            return iter(a + b, a, count - 1)
    return iter(1, 0, n)

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
    def iter(v1, v2, v3, count):
        if (count < 3):
            return v1
        else:
            return iter(1*v1 + 2*v2 + 3*v3, v1, v2, (count - 1))
    if (n < 3):
        return n
    else:
        return iter(2, 1, 0, n)

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
        #print('p: ', angle)
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
    def iter(base, counter, product):
        if (counter == 0):
            return product
        else:
            return iter(base, counter - 1, base * product)
    return iter(base, n, 1)

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
    def iter(base, n, result):
        if (n == 0):
            return result
        elif is_even(n):
            return iter(square(base), n / 2, result)
        else:
            return iter(base, n - 1, base * result)
    return iter(base, n, 1)

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
    def iter(base, n, result):
        if (n == 0):
            return result
        elif is_even(n):
            return iter(double(base), halve(n), result)
        else:
            return iter(base, n - 1, base + result)
    return iter(a, b, 0)

mult_i(7, 143)

# ex.1.19
def fib_fast(n):
    def iter(a, b, p, q, count):
        if (count == 0):
            return b
        elif (is_even(count)):
            return iter(a, b,
                        p * p + q * q,
                        (2 * p + q) * q,
                        count / 2)
        else:
            return iter(b * q + a * q + a * p,
                        b * p + a * q,
                        p, q, count - 1)
    return iter(1, 0, 0, 1, n)

fib_fast(10)

"""
>>> fib_fast(10)
55
>>> fib_fast(100)
354224848179261915075
"""

# 1.2.5
def gcd(m, n):
    if (n == 0):
        return m
    else:
        #print('m =', m, '; n =', n)
        return gcd(n, m % n)

gcd(206, 40)

# 1.2.6
def smallest_divisor_(n):
    def find_divisor(n, test):
        if (square(test) > n):
            return n
        elif (n % test == 0):
            return test
        else:
            return find_divisor(n, (test + 1))
    return find_divisor(n, 2)

def is_prime_(n):
    return n == smallest_divisor_(n)

# ex.1.21
[is_prime_(n) for n in [199, 1999, 19999]]

# ex.1.23
def smallest_divisor(n):
    def next(test):
        if (test == 2):
            return 3
        else:
            return test + 2
    def find_divisor(n, test):
        if (square(test) > n):
            return n
        elif (n % test == 0):
            return test
        else:
            return find_divisor(n, next(test))
    return find_divisor(n, 2)

def is_prime(n):
    return n != 1 and n == smallest_divisor(n)

[is_prime(n) for n in [199, 1999, 19999]]

# Fermet Test and Carmichael numbers
carmicaels = [561, 1105, 1729, 2465, 2821, 6601]
[is_prime(n) for n in carmicaels]

def expmod(base, exp, m):
    if (exp == 0):
        return 1
    elif (is_even(exp)):
        return (square(expmod(base, exp / 2, m))) % m
    else:
        return (base * expmod(base, exp - 1, m)) % m

def fermat_test(n):
    def try_it(a):
        return expmod(a, n, n) == a
    return try_it(random.randint(1, n))

def is_prime_fermat(n, times):
    if (times == 0):
        return True
    elif fermat_test(n):
        return is_prime_fermat(n, times - 1)
    else:
        return False

[is_prime_fermat(n, 10) for n in [199, 1999, 19999]]
[is_prime_fermat(n, 10) for n in carmicaels]

# ex.1.27
def fermat_test_all(n):
    def try_it(a):
        return expmod(a, n, n) == a
    def iter(a):
        if (n == 1):
            return False
        elif (a == n):
            return True
        elif (try_it(a)):
            return iter(a + 1)
        else:
            return False
    return iter(1)

fermat_test_all(carmicaels[0])

"""
import sys
sys.setrecursionlimit(2000)
[fermat_test_all(n) for n in carmicaels[:3]]
# [True, True, True]
"""

# ex.1.28
def miller_rabin_test(n):
    def square_with_check(x, m):
        mx = square(x) % m
        if (x == 1):
            return mx
        elif (x == m - 1):
            return mx
        elif (mx == 1):
            return 0
        else:
            return mx
    def expmod_with_check(base, exp, m):
        if (exp == 0):
            return 1
        elif (is_even(exp)):
            return square_with_check(expmod_with_check(
                base, exp / 2, m), m)
        else:
            return base * expmod_with_check(
                base, exp - 1, m) % m
    def try_it(a):
        return expmod_with_check(a, n, n) == a
    return try_it(random.randint(1, n))

def is_prime_miller_rabin(n, times):
    if (times == 0):
        return True
    elif miller_rabin_test(n):
        return is_prime_miller_rabin(n, times - 1)
    else:
        return False

[is_prime_miller_rabin(n, 10) for n in [199, 1999, 19999]]
# [True, True, False]

[is_prime_miller_rabin(n, 10) for n in carmicaels]
# [False, False, False, False, False, False]

# 1.3.1
def sum_recursive(term, a, next, b):
    if a > b:
        return 0
    else:
        return term(a) + sum_recursive(
            term, next(a), next, b)

def inc(n):
    return n + 1

def sum_cubes_r(a, b):
    return sum_recursive(cube, a, inc, b)

sum_cubes_r(1, 10)

def identity(n):
    return n

def sum_integers(a, b):
    return sum_recursive(identity, a, inc, b)

sum_integers(1, 10)

def pi_sum_(a, b):
    def pi_term(x):
        return 1 / (x * (x + 2))
    def pi_next(x):
        return x + 4
    return sum_recursive(pi_term, a, pi_next, b) * 8

pi_sum_(1, 1000)
# 3.139592655589783

def integral_(f, a, b, dx):
    def add_dx(x):
        return x + dx
    return sum_recursive(f, a + dx / 2, add_dx, b) * dx

integral_(cube, 0, 1, 1e-2)
# 0.24998750000000042

integral_(cube, 0, 1, 2e-3)
# 0.24999950000000098

# ex.1.30
def sum_iterative(term, a, next, b):
    def iter(a, result):
        if (a > b):
            return result
        else:
            return iter(next(a), term(a) + result)
    return iter(a, 0)

def sum_cubes_i(a, b):
    return sum_iterative(cube, a, inc, b)

sum_cubes_i(1, 10)

# ex.1.29
def simpson(f, a, b, n):
    h = (b - a) / n
    def y(k):
        return f(a + k * h)
    def term(k):
        coefficient = 1 if ((k == 0) or (k == n)) else 2 if (is_even(k)) else 4
        return coefficient * y(k)
    return (h / 3) * sum_iterative(term, 0, inc, n)

simpson(cube, 0, 1, 10) # 0.25

# ex.1.31
def product_recursive(term, a, next, b):
    if a > b:
        return 1
    else:
        return term(a) * product_recursive(
            term, next(a), next, b)

def product_iterative(term, a, next, b):
    def iter(a, result):
        if (a > b):
            return result
        else:
            return iter(next(a), term(a) * result)
    return iter(a, 1)

product_recursive(identity, 1, inc, 10)
product_iterative(identity, 1, inc, 10)

def john_wallis_method(upper):
    def term(k):
        doublek = 2 * k
        denom = doublek * (doublek + 2)
        numer = (doublek + 1) * (doublek + 1)
        return denom / numer
    return 4 * product_iterative(term, 1, inc, upper)

for upper in [2**e for e in range(10)]:
    print(upper, john_wallis_method(upper))

# ex.1.32.
def plus(x, y):
    return x + y
def mult(x, y):
    return x * y

def accumulate_recursive(combiner, initial, term, a, next, b):
    if a > b:
        return initial
    else:
        return combiner(term(a), accumulate_recursive(
            combiner, initial, term, next(a), next, b))
def accumulate_iterative(combiner, initial, term, a, next, b):
    def iter(a, result):
        if (a > b):
            return result
        else:
            return iter(next(a), combiner(term(a), result))
    return iter(a, initial)

def acc_sum(term, a, next, b):
    return accumulate_recursive(plus, 0, term, a, next, b)
def acc_product(term, a, next, b):
    return accumulate_recursive(mult, 1, term, a, next, b)

def acc_pi_sum(a, b):
    return 8 * acc_sum(
        lambda x : 1 / (x * (x + 2)), a,
        lambda x : x + 4, b)
[acc_pi_sum(1, to) for to in [10, 100, 1000]]
# [2.976046176046176, 3.1215946525910105, 3.139592655589783]

def acc_fact(n):
    return acc_product(identity, 1, inc, n)
[acc_fact(n) for n in range(11)]
# [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800]

# ex.1.33.
def filtered_accumulate(combiner, initial, term, a, next, b, predicate):
    def iter(a, result):
        if (a > b):
            return result
        elif predicate(a):
            return iter(next(a), combiner(term(a), result))
        else:
            return iter(next(a), result)
    return iter(a, initial)

def ex_1_33_a(a, b):
    return filtered_accumulate(
        plus, 0, square, a, inc, b, is_prime)
ex_1_33_a(1, 10) == sum(map(square, [2, 3, 5, 7]))

def ex_1_33_b(n):
    def is_relatively_prime_to_n(m):
        return gcd(m, n) == 1
    return filtered_accumulate(
        mult, 1, identity, 1, inc, n, is_relatively_prime_to_n)
ex_1_33_b(8) == 3 * 5 * 7

# 1.3.2
def pi_sum(a, b):
    return 8 * sum_recursive(
        lambda x : 1 / (x * (x + 2)),
        a,
        lambda x : x + 4,
        b)

pi_sum(1, 1000)
# 3.139592655589783

def integral(f, a, b, dx):
    return sum_recursive(
        f, a + dx / 2, lambda x : x + dx, b) * dx

integral(cube, 0, 1, 2e-3)
# 0.24999950000000098

# ex.1.34
def f(g):
    return g(2)

"""
>>> f(square)
4
>>> f(lambda z : z * (z + 1))
6
>>> f(f)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 2, in f
  File "<stdin>", line 2, in f
TypeError: 'int' object is not callable
"""

# 1.3.3
def search(f, neg_point, pos_point):
    def is_close_enough(x, y):
        return abs(x - y) < 1e-6
    mid_point = (neg_point + pos_point) / 2
    if is_close_enough(neg_point, pos_point):
        return mid_point
    value_mid = f(mid_point)
    if (value_mid > 0):
        return search(f, neg_point, mid_point)
    elif (value_mid < 0):
        return search(f, mid_point, pos_point)
    else:
        return mid_point

def half_interval_method(f, a, b):
    value_a = f(a)
    value_b = f(b)
    if (value_a < 0 and 0 < value_b):
        return search(f, a, b)
    elif (value_b < 0 and 0 < value_a):
        return search(f, b, a)
    else:
        raise ValueError("Values are not of opposite sign", a, b)

half_interval_method(sine, 2, 4) # sine is defined by ex.1.15
# 3.1408047676086426

from math import *
half_interval_method(sin, 2, 4)
# 3.141592502593994

half_interval_method(lambda x : x ** 3 - 2 * x - 3, 1, 2)
# 1.8932890892028809

def fixed_point(f, first_guess):
    def is_close_enough(x, y):
        return abs(x - y) < 1e-6
    def try_it(guess):
        next = f(guess)
        if (is_close_enough(guess, next)):
            return next
        else:
            return try_it(next)
    return try_it(first_guess)

fixed_point(cos, 1)
# 0.7390855263619245

fixed_point(lambda y : sin(y) + cos(y), 1)
# 1.2587277968014188

def average(x, y):
    return (x + y) / 2

def fixed_sqrt(x):
    return fixed_point(lambda y : average(y, x / y), 1)

[fixed_sqrt(x) for x in [2, 3, 5]]
# [1.414213562373095, 1.7320508075688772, 2.236067977499978]

# ex.1.35
def fixed_phi():
    return fixed_point(lambda x : average(x, 1 + 1 / x), 1)

fixed_phi()
# 1.6180337185494662

# ex.1.36
def fixed_point_with_print(f, first_guess):
    def is_close_enough(x, y):
        return abs(x - y) < 1e-6
    def try_it(guess):
        next = f(guess)
        print("guess: ", guess, "next: ", next)
        if (is_close_enough(guess, next)):
            return next
        else:
            return try_it(next)
    return try_it(first_guess)

fixed_point_with_print(lambda x : log(1000) / log(x), 10)
# try_it(guess) called 39 times.

fixed_point_with_print(lambda x : average(x, log(1000) / log(x)), 10)
# try_it(guess) called 11 times.

# ex.1.37
def cont_frac_recursive(numer, denom, terms):
    def iter(i):
        if i > terms:
            return 0
        else:
            return numer(i) / (denom(i) + iter(i + 1))
    return iter(1)

def cont_frac_iterative(numer, denom, terms):
    def iter(i, result):
        if (i == 0):
            return result
        else:
            return iter(i - 1, numer(i) / (denom(i) + result))
    return iter(terms, 0)

def cont_phi(terms, which):
    return 1 / which(lambda n : 1, lambda d : 1, terms)

def cont_phi_recursive(terms):
    return cont_phi(terms, cont_frac_recursive)

def cont_phi_iterative(k):
    return cont_phi(terms, cont_frac_iterative)

for terms in range(1, 20 + 1):
    print(terms, cont_phi_recursive(terms), cont_phi_iterative(terms))

# ex.1.38
def cont_napier(terms, which):
    return 2 + which(
        lambda n : 1,
        lambda d : 1 if d % 3 != 2 else 2 * (d + 1) / 3,
        terms)

def cont_napier_recursive(terms):
    return cont_napier(terms, cont_frac_recursive)

def cont_napier_iterative(terms):
    return cont_napier(terms, cont_frac_iterative)

for terms in range(1, 10 + 1):
    print(terms, cont_napier_recursive(terms), cont_napier_iterative(terms))

# ex.1.39
def tan_cf(x, terms, which):
    def minus_xtanx():
        return which(lambda n : -1 * x * x,
                     lambda d : 2 * d - 1,
                     terms)
    return -1 * minus_xtanx() / x

tan_cf(pi, 10, cont_frac_iterative)
tan_cf(pi, 10, cont_frac_recursive)
# -1.8932141493591683e-09 ; tan(pi) = 0

tan_cf(pi / 2, 10, cont_frac_iterative)
tan_cf(pi / 2, 10, cont_frac_recursive)
# 744656605476677.9 ; tan(pi/2) = nan

tan_cf(pi / 4, 10, cont_frac_iterative)
tan_cf(pi / 4, 10, cont_frac_recursive)
# 1.0 ; tan(pi/4) = 1

tan_cf(pi / 3, 10, cont_frac_iterative)
tan_cf(pi / 3, 10, cont_frac_recursive)
# 1.7320508075688767 ; tan(pi/3) = sqrt(3)

# 1.3.4
def average_damp(f):
    return lambda x : average(x, f(x))

average_damp(square)(10)
# 55.0

def re_sqrt(x):
    return fixed_point(average_damp(lambda y : x / y),
                       1.0)

re_sqrt(2)
# 1.414213562373095
re_sqrt(3)
# 1.7320508075688772

def re_cbrt(x):
    return fixed_point(average_damp(lambda y : x / square(y)),
                       1.0)

cube(re_cbrt(2))
# 1.9999986984189864
cube(re_cbrt(3))
# 2.99999826198191

dx = 1e-6
def deriv(g):
    return lambda x : (g(x + dx) - g(x)) / dx

deriv(cube)(5) # (x**3)'(5) = (3 * x**2)(5) = 3 * 25 = 75.
# 75.00001501625775

def newton_transform(g):
    return lambda x : x - g(x) / deriv(g)(x)
def newtons_method(g, guess):
    return fixed_point(newton_transform(g), guess)

def newton_sqrt(x):
    return newtons_method(lambda y : square(y) - x, 1.0)

newton_sqrt(2)
# 1.4142135623730951
newton_sqrt(3)
# 1.732050807568878

def fixed_point_of_transform(g, transform, guess):
    return fixed_point(transform(g), guess)

def sqrt1(x):
    return fixed_point_of_transform(
        lambda y : x / y, average_damp, 1.0)

def sqrt2(x):
    return fixed_point_of_transform(
        lambda y : square(y) - x, newton_transform, 1.0)

sqrt1(2)
# 1.414213562373095
sqrt2(2)
# 1.4142135623730951

# ex.1.40
def cubic(a, b, c):
    return lambda x : cube(x) + a * square(x) + b * x + c

def solve_cubic(a, b, c):
    return newtons_method(cubic(a, b, c), 1.0)

solve_cubic(0, 0, -8) # (x-2)^3=0
# 2.0
solve_cubic(-3, 1, -3) # (x-3)(x^2+1)=0
# 3.0
solve_cubic(-4, -3, 18) # (x-3)^2(x+2)=0
# 2.9999998505332477
solve_cubic(4, -3, -18) # (x+3)^2(x-2)=0
# 2.0000000000000058

# ex.1.41
def double(f):
    return lambda x : f(f(x))

inc(5) # 6 = 5 + 1
double(inc)(5) # 7 = 5 + 1 * 2
double(double)(inc)(5) # 9 = 5 + 1 * 2 ** 2
double(double(double))(inc)(5) # 21 = 5 + 1 * (2 ** 2) ** 2
double(double(double(double)))(inc)(5) # 261 = 5 + 1 * ((2 ** 2) ** 2) ** 2

# ex.1.42
def compose(f, g):
    return lambda x : f(g(x))

compose(square, inc)(5) # 36 = square(inc(5))
compose(inc, square)(5) # 26 = inc(square(5))

# ex.1.43
def repeated(f, n):
    if (n == 0):
        return lambda x : x
    else:
        return compose(f, repeated(f, n - 1))

repeated(square, 1)(2) # 2 = 2 ** (2**1)
repeated(square, 2)(2) # 16 = 2 ** (2**2)
repeated(square, 3)(2) # 256 = 2 ** (2**3)
repeated(square, 4)(2) # 65536 = 2 ** (2**4)
repeated(square, 2)(5) # 625 = 5 ** (2**2)
