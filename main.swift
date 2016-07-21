import Foundation

// TODO: go back and do vis modifiers properly, then remove @testable
@testable import Nifty

/// Demo function
func main()
{
    print("\n\n\n====================\n     N I F T Y\n====================\n")

    testMaxTime()
    testMatrixInversion()
    testSubscripts()
    testMatrixTranspose()
    testFastRand()
    testRandTime()
}

/// Test time to find max in list
func testMaxTime()
{
    let N = 1000
    let TRIALS = 10

    // get list of random ints
    let M = randi([1,N], imax: 9999)
    var a = [Int]()
    for i in 0..<numel(M)
    {
        a.append(Int(M[i]))
    }

    // find the maximum value using max
    var t = 0.0
    var x = 0
    for _ in 0..<TRIALS
    {
        tic()
        x += a.max()!
        t += toc()
    }
    print("Average time using max() to compute x=\(x): \(t/Double(TRIALS)) seconds")

    // find the maximum value using for loop
    t = 0.0
    x = 0
    for _ in 0..<TRIALS
    {
        tic()
        var b = 0
        for el in 0..<N
        {
            if a[el] > b
            {
                b = a[el]
            }
        }
        x += b
        t += toc()
    }
    print("Average time using for loop to compute x=\(x): \(t/Double(TRIALS)) seconds")
}

/// Test matrix inversion
func testMatrixInversion()
{
    let A = Matrix(data: [[7,2,1],[0,3,-1],[-3,4,-2]])
    print(A)
    print("Computing A inverse...\n")
    tic()
    let Ai = inv(A)
    let _ = toc(units: "ms")    
    print(Ai)

    var N = 5
    print("\nInverting \(N)-by-\(N) matrix...")
    let B = randi([N,N], imax:99)
    print(B)
    tic()
    let Bi = inv(B)
    let _ = toc(units: "ms")
    print(Bi)

    N = 10
    print("\nInverting \(N)-by-\(N) matrix...")
    let C = rand([N,N])
    print(C)
    tic()
    let Ci = inv(C)
    let _ = toc(units: "ms")
    print(Ci)
}

/// Test transpose of matrix
func testMatrixTranspose()
{
    print("\n*** Testing matrix transpose...\n")

    let A = randi([10,10], imax:99)
    print("A is...\n\(A)")

    let At = transpose(A)
    print("At is...\n\(At)")

    let B = randi([4,6], imax:99)
    print("B is...\n\(B)")

    let Bt = B~
    print("Bt is...\n\(Bt)")

    let N = 1000
    let M = rand([N,N])
    print("Transposing \(N)x\(N) matrix...")
    tic()
    let Mt = transpose(M)
    let _ = toc(units: "ms")    
    let _ = numel(Mt) // appease unused warning
}

/// Ensure that rapid-fire calls to rand don't result in repeats
func testFastRand()
{
    print("\n*** Testing fast random...\n")
    for _ in 0...1000
    {
        print(randi([1,4], imax:2147483647))
    }
}

/// Time how long it takes to create random matrices
func testRandTime()
{
    print("\n*** Timing random matrix creation...\n")

    let L = 10000
    let S = 50
    let NUM = 10000
    let IMAX = 100

    // Floating Point Matrix (0,1)
    print("Creating \(L)x\(L) (0,1) matrix... ", terminator:"")
    tic()
    let m1 = rand([L,L])
    let _ = toc(units: "s")
    let _ = numel(m1) // appease unused warning

    print("Creating \(NUM) \(S)x\(S) (0,1) matrices... ", terminator:"")
    var m2 = zeros([2,2])
    tic()
    for _ in 0..<NUM
    {
        m2 = rand([S,S])
    }
    let _ = toc(units: "s")
    let _ = numel(m2)

    // Integer Matrix
    print("Creating \(L)x\(L) [0,\(IMAX)] matrix... ", terminator:"")
    tic()
    let m3 = randi([L,L], imax: IMAX)
    let _ = toc(units: "s")
    let _ = numel(m3) // appease unused warning
    
    print("Creating \(NUM) \(S)x\(S) [0,\(IMAX)] matrices... ", terminator:"")
    var m4 = zeros([2,2])
    tic()
    for _ in 0..<NUM
    {
        m4 = randi([S,S], imax: IMAX)
    }
    let _ = toc(units: "s")
    let _ = numel(m4) // appease unused warning
}

/// Test matrix subscript functionality
func testSubscripts()
{
    print("\n*** Testing matrix subscripting...\n")

    let m1 = Matrix(size: [2, 2], data: [1.1, 2.2, 3.3, 4.4])
    let m2 = Matrix(size: [2, 2], data: [11.1, 22.2, 33.3, 44.4])
    let m3 = m1 + m2
    let m4 = Matrix(size: [4, 4], 
        data: [11,21,31,41,12,22,32,42,13,23,33,43,14,24,34,44])

    let m5data: [[Double]] = [[11,12,13,14,15,16], [21,22,23,24,25,26], [31,32,33,34,35,36]]
    var m5 = Matrix(data: m5data)

    print("m1:\(m1)")
    print("m1[0,0]=\(m1[0,0])")
    print("m1[0,1]=\(m1[0,1])")
    print("m1[1,0]=\(m1[1,0])")

    print("m2:\(m2)")
    
    print("m3:\(m3)")
    
    print("m4:\(m4)")
    print("m4[2,0..<3]:\(m4[slice: 2,0..<3])")
    print("m4[1,2]:\(m4[1,2])")

    print("m5:\(m5)")
    print("m5[0...1,1..<5]:\(m5[slice: 0...1,1..<5])")

    m5[slice: 2,0...3] = Matrix(data:[0,1,2,3])
    print("m5:\(m5)")
}

/// Test methods that create new matrices
func testMatrixCreation()
{
    print("\n*** Testing matrix creation...\n")

    print("eye(4) = \(eye(4))")
    print("eye([2,3]) = \(eye([2,3]))")
    print("ones(4) = \(ones(4))")
    print("ones([2,3]) = \(ones([2,3]))")
    print("zeros(4) = \(zeros(4))")
    print("zeros([2,3]) = \(zeros([2,3]))")
    print(nan(4))
    print(nan([3,7]))
    print(inf([5]))
    print(inf([2,4]))
}

/// Test function for finding most significant bit location
func testMsb()
{
    print("\n*** Testing MSB...\n")

    print("msb(0)=\(msb(UInt(0)))")
    print("msb(1)=\(msb(UInt(1)))")
    print("msb(2)=\(msb(UInt(2)))")
    print("msb(3)=\(msb(UInt(3)))")
    print("msb(4)=\(msb(UInt(4)))")
    print("msb(7)=\(msb(UInt(7)))")
    print("msb(8)=\(msb(UInt(8)))")
    print("msb(15)=\(msb(UInt(15)))")
    print("msb(16)=\(msb(UInt(16)))")
    print("msb(31)=\(msb(UInt(31)))")
    print("msb(32)=\(msb(UInt(32)))")
    print("msb(33)=\(msb(UInt(33)))")
    print("msb(1023)=\(msb(UInt(1023)))")
    print("msb(1024)=\(msb(UInt(1024)))")
    print("msb(2147483647)=\(msb(UInt(2147483647)))")
    print("msb(2147483648)=\(msb(UInt(2147483648)))")
    print("msb(4294967295)=\(msb(UInt(4294967295)))")
    print("msb(9223372036854775807)=\(msb(UInt(9223372036854775807)))")
    let max64: UInt = 9223372036854775808
    print("msb(9223372036854775808)=\(msb(max64))")
}

/// Test functions/wrappers from math
func testMath()
{
    print("\n*** Testing glibc math wrappers...\n")

    print("acos: \(acos.dynamicType)")
    print("acos(.45)=\(acos(0.45))")

    // TODO: bring in complex number stuff from glibc
    let acos15 = acos(1.5)
    print("acos(1.5)=\(acos15)")
    print(acos15.dynamicType)
    //print("acos(1.5) is nan? \(isnan(acos15))")

    print("acosd(.45)=\(acosd(0.45))")
    print("acosh: \(acosh.dynamicType)")
    print("asin: \(asin.dynamicType)")
    print("asin(.45)=\(asin(0.45))")
    print("asind(.45)=\(asind(0.45))")
    print("asinh: \(asinh.dynamicType)")
    print("atan: \(atan.dynamicType)")
    print("atan(.45)=\(atan(0.45))")
    print("atand(.45)=\(atand(0.45))")
    print("atan2: \(atan2.dynamicType)")
    print("atan2(.45,.2)=\(atan2(0.45,0.2))")
    print("atan2d(.45,.2)=\(atan2d(0.45,0.2))")
    print("atanh: \(atanh.dynamicType)")
    print("ceil: \(ceil.dynamicType)")
    print("cos: \(cos.dynamicType)")
    print("cos(pi)=\(cos(Pi))")
    print("cosd(60)=\(cosd(60.0))")
    print("cosh: \(cosh.dynamicType)")
    print("exp: \(exp.dynamicType)")
    print("exp2: \(exp2.dynamicType)")
    print("expm1: \(expm1.dynamicType)")
    print("floor: \(floor.dynamicType)")
    print("hypot: \(hypot.dynamicType)")
    print("log: \(log.dynamicType)")
    print("log10: \(log10.dynamicType)")
    print("log2: \(log2.dynamicType)")
    print("log1p: \(log1p.dynamicType)")
    print("pow: \(pow.dynamicType)")
    print("round: \(round.dynamicType)")
    print("sin: \(sin.dynamicType)")
    print("sin(pi)=\(sin(Pi))")
    print("sind(60)=\(sind(60.0))")
    print("sinh: \(sinh.dynamicType)")
    print("sqrt: \(sqrt.dynamicType)")
    print("tan: \(tan.dynamicType)")
    print("tan(pi)=\(tan(Pi))")
    print("tand(60)=\(tand(60.0))")
    print("tanh: \(tanh.dynamicType)")

    print("e=\(E)") 
    print("pi=\(Pi)") 

    print("ceil(6.1)=\(ceil(6.1))")
    print("round(6.501)=\(round(6.501))")
    print("floor(6.501)=\(floor(6.501))")

    print("rand()=\(rand())")
    print("rand([2,3])=\(rand([2,3]))")

    print("randi(100)=\(randi(imax: 100))")
    print("randi([2,3], imax:4)=\(randi([2,3], imax: 4))")
}

/// Call main function
main()
