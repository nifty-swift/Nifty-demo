# Nifty Demo

[![License](https://img.shields.io/hexpm/l/plug.svg)](LICENSE)

Here's a simple example of Nifty in action!

## Overview

##### Fundamental Types

Nifty offers three fundamental types of data structures: vectors, matrices, and tensors, with various initializers for each. For example,

```swift
var V = Vector([2.34, 6, 0.000000034, 67.234, 98456456.234])

var M = Matrix([[276.0251,  498.3641,  751.2671], 
                [679.7027, -959.7440,  255.0951],
                [655.0980, -340.3857,  505.9571]])
                
let size = [3,1,3]
var T = Tensor(size, M.data)
```

Each type provides methods for cleanly displaying the data it contains. For example, calling `print(V)` displays,

```
<2.34   6   3.4E-8   67.234   9.846E7>
```

calling `print(M)` displays,

```
R0:   276.025    498.364   751.267
R1:   679.703   -959.744   255.095
R2:   655.098   -340.386   505.957
```

and calling `print(T)` displays,

```
[..., ..., 0]:
R0:   276.025
R1:   679.703
R2:   655.098

[..., ..., 1]:
R0:    498.364
R1:   -959.744
R2:   -340.386

[..., ..., 2]:
R0:   751.267
R1:   255.095
R2:   505.957
```

By default, the data is rounded to keep the display compact, but the settings can be adjusted for each structure. Additionally, each structure can be set to have a name displayed along with the contents,

```swift
M.name = "MyNiftyMatrix"
M.showName = true
```

Now, calling print(M) displays,

```
MyNiftyMatrix:
R0:   276.025    498.364   751.267
R1:   679.703   -959.744   255.095
R2:   655.098   -340.386   505.957
```

Nifty fundamental structures are all zero-indexed, stored in row-major order, and can be easily indexed, subscripted, and sliced:

```swift
V[3] = 3.0

M[0] = 0.1
M[4] = 1.1
M[8] = 2.2

M[0,1] = 0.1
M[1,1] = 1.1
M[2,2] = 2.2

M[1...2,1...2] = Matrix(2, [11,12,21,22]) 

let t = T[0, 0, 0..<3]
```

Most of the functionality provided by Nifty is based on these fundamental types, which usually contain floating-point numbers. However, all of the fundamental types are generic, and can contain any type of values. For example,

```swift
let Ms = Matrix(2, 4, value: "X")
```

creates a 2-by-4 matrix containing the letter "X" in each cell, which displays as,

```
R0:   X   X   X   X
R1:   X   X   X   X
```

##### Linear Algebra

Nifty provides a variety of linear algebra functions, mainly operating `Matrix<Double>` types.

Here's an example of how we could invert a matrix, using both the function `inv()` and the symbolic prefix operator `~` (Nifty provides symbolic operators for a variety of common math functions):

```swift
let Mi = ~M 
let _  = inv(M)
```

Here, we'll use Nifty to solve the system of equations `A*x = B` for `x`:

```swift
let A = Matrix<Double>([[21,  3,  4,  4, 17],
                        [23,  7, 25, 11,  1],
                        [ 4, 14, 24, 23, 22],
                        [23, 24, 13, 20, 24],
                        [16, 25, 21, 24, 17]], name: "A")

let B = Matrix<Double>([[18, 21, 11, 13,  7],
                        [ 1, 18, 10, 12, 17],
                        [ 7,  8, 20, 17, 17],
                        [ 2, 24, 20, 18,  5],
                        [ 3,  1,  5, 19,  3]], name: "B")

let x = A-/B   // or, mldivide(A, B)
```

Calling `print(x)` displays the following (Note that the output matrix was given a name based on the inputs' names and the transform applied--all Nifty functions do this by default!):

```
mldivide(A, B):
R0:    4.45782   -5.77337   -5.80571    1.63021   -2.26439
R1:   -12.5532    17.9503     16.122   -3.95338    5.81648
R2:   -10.5024    16.5735    15.0794   -3.31092     6.6158
R3:       23.1   -36.2762   -32.3031    7.87055   -12.7877
R4:   -5.19676    9.83532     9.0264   -1.62428    3.63471

```

There is a lot more of linear algebra functionality in Nifty--check out the demo code for some more examples or the Nifty documentation for a complete listing.

##### Random Numbers

Nifty also provides a variety of easy-to-use random number functions. For example, a 6-by-3 matrix of random whole numbers between 35 and 110:

```
let Ri = randi(6, 3, min: 35, max: 110)
```

Or a list of 5 random vectors from a multivariate normal distribution:

```
let mu      = Vector([2.0,3.0], name: "μ")       
let sigma   = Matrix<Double>([[1,1.5],[1.5,3.0]], name: "Σ")
let vectors = mvnrnd(mu: mu, sigma: sigma, cases: 5)
```

##### Timing

Nifty makes timing code snippets particularly easy. MATLAB users will be familiar with `tic` and `toc`, which start a stopwatch, and return the time on the stopwatch, respectively. For example,

```
tic()
let Z = randi(500, 500, min: -999, max: 999)
toc()
```

displays the number of seconds it took to generate Z. Times are by default in seconds, but the default can be overridden to provide the ellapsed time in the desired units. For example,

```
tic()
let Zi = inv(Z)
toc(.ms)
```

displays the ellapsed time in milliseconds. Rather than displaying the time, the result can be stored to a variable. For example,

```
tic()
let _ = Z * Zi
let time = toc(returning: .minutes)
```

## Running the Demo 

Getting Nifty running is easy; follow the steps below:

- Clone this repository
- Make sure you've met the requirements for [Nifty](https://github.com/nifty-swift/Nifty#getting-started)
- Open a terminal inside your local copy of this repository
- Run `swift build`. You should see the package manager cloning into various repositories to gather the needed packages, compiling, and then linking. 
- Once the build has completed, execute `.build/debug/Nifty-demo` to run the demo!

   _Look [here](https://github.com/nifty-swift/Nifty#troubleshooting) if you get linker errors while building_