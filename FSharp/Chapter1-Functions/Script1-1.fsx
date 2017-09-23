// 1.1.1

let plus x y = x + y
plus 21 35
let mult x y = x * y
mult 7 3
let minus x y = x - y

mult 3 (plus (2 * 4) (3 + 5)) |> plus ((10 - 7) + 6);;
// val it : int = 57

open System

// 1.1.2

let pi = Math.PI
let radius = 10
pi * float(radius * radius);;
// val it : float = 314.1592654

let circum = float(2) * pi * float(radius)
// val circum : float = 62.83185307

// 1.1.4

let square_int x : int = x * x
square_int 21
square_int (plus 2 5)
square_int (square_int 3)

let circumference radius = 2.0 * pi * radius
circumference 10.0
// val it : float = 62.83185307

let sum_of_square_int x y = plus (square_int x) (square_int y)
sum_of_square_int 3 4
// val it : int = 25
