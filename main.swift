/// Simple Nifty demo project.

import Nifty

print("\n======\nNifty!\n======\n")

tic()

// create a matrix
var M = Matrix([[276.0251,  498.3641,  751.2671], 
                [679.7027, -959.7440,  255.0951],
                [655.0980, -340.3857,  505.9571]])

// optionally, give it a name
M.name = "NiftyMatrix"
M.title = true

// display a matrix/slices
print("\(M)\n")
print("\(M[1...2])\n")
print("\(M[0..<2,1...2])\n")

// modify a matrix/slice
M[0,1] = 12346.789
M[1...2,1...2] = Matrix(size: [2,2], data: [11,12,21,22]) 
print("\(M)\n")

// display matrix information
print("M has \(M.numel) elements, and its size is \(M.size)\n")

// invert a matrix
let M_inv = ~M
print("\(M_inv)\n")

// transpose a matrix
let M_transpose = M^ 
print("\(M_transpose)\n")

// solve A*x = B for x
let A = Matrix([[21,  3,  4,  4, 17],
                [23,  7, 25, 11,  1],
                [ 4, 14, 24, 23, 22],
                [23, 24, 13, 20, 24],
                [16, 25, 21, 24, 17]], name: "A", title: true)

let B = Matrix([[18, 21, 11, 13,  7],
                [ 1, 18, 10, 12, 17],
                [ 7,  8, 20, 17, 17],
                [ 2, 24, 20, 18,  5],
                [ 3,  1,  5, 19,  3]], name: "B", title: true)

let x = A-/B
print("\(x)\n")

// solve y*A = B for y
let y = B/A
print("\(y)\n")

// multiply matrices
print("\(A*B)\n")
let C = Matrix(size: [4,2], data: [1,2,3,4,5,6,7,8])
let D = Matrix(size: [2,2], value: 4.5)
var CD = C*D 
CD.title = true
print("\(CD)\n")

// create random numbers
print("Random number [0, 1): \(rand())\n")
print("Random matrix [0, 1):\n\(rand([4,5]))\n")
print("Random integer [0, 500): \(randi(max: 500))\n")
print("Random integer matrix [0, 345):\n\(randi([6,3], max: 345))\n")

toc()