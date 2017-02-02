// Simple Nifty demo project.

import Nifty

print("\nNIFTY DEMO\n")

//------------------------------------------------------------------------------
// FUNDAMENTAL STRUCTURES

// Create structures:
var v = Vector([2.34, 6, 0.000000034, 67.234, 98456456.234])

var M = Matrix([[276.0251,  498.3641,  751.2671], 
                [679.7027, -959.7440,  255.0951],
                [655.0980, -340.3857,  505.9571]])
                
var T = Tensor([3, 1, 3], [0.0, 0.1, 0.2, 1.0, 1.1, 1.2, 2.0, 2.1, 2.2])

print("\(v)\n")
print("\(M)\n")
print("\(T)\n")

// Name matrix:
M.name = "MyNiftyMatrix"
M.showName = true

print("\(M)\n")

// Index, subscript, and slice:
v[3] = 3.0

M[0] = 0.1
M[4] = 1.1
M[8] = 2.2

M[0,1] = 0.1
M[1,1] = 1.1
M[2,2] = 2.2

M[1...2,1...2] = Matrix(2, [11, 12, 21, 22]) 

let t = T[0,0,0..<3]

print("\(v)\n")
print("\(M)\n")
print("\(t)\n")

// String matrix:
let Ms = Matrix(2, 4, value: "X")

print("\(Ms)\n")

//------------------------------------------------------------------------------
// LINEAR ALGEBRA

// Invert:
let Mi = ~M   
let _ = inv(M)

print("\(Mi)\n")

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

let x = A-/B   // or, mldivide(A, B)

print("\(x)\n")

// Solve y*A = B for y:
let y = B/A   // or, mrdivide(B, A)

print("\(y)\n")

// Singular value decomposition, multiplication, and transpose:
let X = Matrix<Double>([[1,2],[3,4],[5,6],[7,8]], name: "A")
let (U,S,V) = svd(X)

print("\(X)\n")
print("\(U)\n")
print("\(S)\n")
print("\(V)\n")
print("\(U*S*V^)\n")  // or, transpose(V)

//------------------------------------------------------------------------------
// RANDOM NUMBERS

let r = rand()

print("Random number [0, 1): \(r)\n")

let R = rand(4, 5, min: -3.5, max: 15.7)

print("Random matrix [0, 1):\n\(R)\n")

let ri = randi(max: 500)

print("Random integer [0, 500): \(ri)\n")

let Ri = randi(6, 3, min: 35, max: 110)

print("Random integer matrix:\n\(Ri)\n")

let rn = randn()

print("Normal random numer ~(0, 1): \(rn)\n")

let Rn = randn(7, 4, mean: 5.5, std: 0.1)

print("Normal random numers ~(5.5, 0.01):\n\(Rn)\n")

let mu      = Vector([2.0,3.0], name: "μ")       
let sigma   = Matrix<Double>([[1,1.5],[1.5,3.0]], name: "Σ")
let vectors = mvnrnd(mu: mu, sigma: sigma, cases: 5)

print("\(mu)\n")
print("\(sigma)\n")
print("\(vectors.map({"\($0)"}).joined(separator: "\n"))\n")

//------------------------------------------------------------------------------
// TIMING

// Time random number generation in seconds:
tic()
let Z = randi(500, 500, min: -999, max: 999)
toc()

// Time matrix inversion in milliseconds:
tic()
let Zi = inv(Z)
toc(.ms)

// Store time for matrix multiplication:
tic()
let _ = Z * Zi
let time = toc(returning: .minutes)