# Nifty Demo

[![License](https://img.shields.io/hexpm/l/plug.svg)](LICENSE)

Here's a simple example of Nifty in action!

## Overview

###### Fundamental Structures

Nifty offers three fundamental data structures: vectors, matrices, and tensors.

```swift
let V = Vector([2.34, 6, 0.000000034, 67.234, 98456456.234])

var M = Matrix([[276.0251,  498.3641,  751.2671], 
                [679.7027, -959.7440,  255.0951],
                [655.0980, -340.3857,  505.9571]])
                
let size = [3,1,3]
let T = Tensor(size, M.data)
```

TODO: continue fleshing this section of the README out... for now, just check out the main.swift file for the complete demo


###### Linear Algebra


###### Random Numbers


## Running the Demo 

Getting Nifty running is easy; follow the steps below:

- Clone this repository
- Make sure you've met the requirements for [Nifty](https://github.com/nifty-swift/Nifty#getting-started)
- Open a terminal inside your local copy of this repository
- Run `swift build`. You should see the package manager cloning into various repositories to gather the needed packages, compiling, and then linking.
- Once the build has completed, execute `.build/debug/Nifty-demo` to run the demo!

   _Look [here](https://github.com/nifty-swift/Nifty#troubleshooting) if you get linker errors while building_