/// Simple Nifty demo project.

import Nifty

print("\n          __  _____  __              \n" +
      "    ____ |__|/ ____|/  |_ ___ __       \n" +
      "   /    \\|  \\   __\\\\   __\\   |  | \n" +
      "  |   |  \\  ||  |   |  |  \\___  |    \n" +
      "  |___|__/__||__|   \\__|  /_____|     \n\n")

//------------------------------------------------------------------------------
// Create a new matrisx. Here, we'll use the constructor that takes a list of row
// data. Also, we'll supply an optional name for the matrix, which will show 
// when printed and also be applied to any transforms of this matrix.
var M = Matrix([[276.0251,  498.3641,  751.2671], 
                [679.7027, -959.7440,  255.0951],
                [655.0980, -340.3857,  505.9571]], name: "M")

// Display the matrix. We can print the entire matrix, slices of the matrix, or
// just single elements.
print(M,              terminator: "\n\n")
print(M[0..<2, 1...2], terminator: "\n\n")
print(M[1,2],         terminator: "\n\n")

// Modify the matrix. We can subscript slices or single elements. Notice that
// we use an alternate initializer to create the square, 2x2 matrix slice.
M[0,1] = 12346.789
M[1...2,1...2] = Matrix(2, [11,12,21,22]) 
print(M, terminator: "\n\n")

// Access basic matrix information. 
print("\(M.name!) has \(M.count) elements, \(M.rows) rows, and \(M.columns) " +
    "columns (size=\(M.size))\n")

//------------------------------------------------------------------------------
// There are two other basic structures: Vectors (like a 1-dimensional matrix), 
// and Tensors (like an n-dimensional matrix). They have interfaces and 
// functionality similar to that of the Matrix structure.

// Vector:
let v = Vector([2.34, 6, 0.000000034, 67.234, 98456456.234])
print(v, terminator: "\n\n")

// Tensor:
let size = [3,4,2,2]
var data = [Int]()
for i in 1...size.reduce(1,*) { data.append(i) }
let T = Tensor(size, data, name: "T")
print(T, terminator: "\n")

//------------------------------------------------------------------------------
// Returning to the Matrix, let's look at some of Nifty's linear algebra. Note
// that matrices are generic and can hold elements of any type. In this case, we
// are explicit about containing doubles.

// Invert:
let Mi = ~M // or, inv(M)
print(Mi, terminator: "\n\n")

// Solve A*x = B for x:
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

let x = A-/B // or, mldivide(A, B)
print(x, terminator: "\n\n")

// Solve y*A = B for y:
let y = B/A // or, mrdivide(B, A)
print(y, terminator: "\n\n")

// Singular value decomposition, multiplication, and transpose:
let X = Matrix<Double>([[1,2],[3,4],[5,6],[7,8]], name: "A")
let (U,S,V) = svd(X)
print(X,                terminator: "\n\n")
print(U,                terminator: "\n\n")
print(S,                terminator: "\n\n")
print(V,                terminator: "\n\n")  
print(U*S*transpose(V), terminator: "\n\n")      

//------------------------------------------------------------------------------
// Nifty also has various random number generators:

print("Random number [0, 1): \(rand())\n")
print("Random matrix [0, 1):\n\(rand(4, 5, min: -3.5, max: 15.7))\n")
print("Random integer [0, 500): \(randi(max: 500))\n")
print("Random integer matrix:\n\(randi(6, 3))\n")
print("Normal random numer ~(0, 1): \(randn())\n")
print("Normal random numers ~(5.5, 0.01):\n\(randn(7, 4, mean: 5.5, std: 0.1))\n")

//------------------------------------------------------------------------------
// It also has a convenient way to time code snippets. The 'tic' function starts
// a global stopwatch, the 'toc' function gives the ellapsed time, by default
// in seconds, but other units can be requested.

// Time random number generation in seconds:
tic()
let R = randi(500, 500, min: -999, max: 999)
toc()

// Time matrix inversion in milliseconds
tic()
let Ri = inv(R)
toc(.ms)