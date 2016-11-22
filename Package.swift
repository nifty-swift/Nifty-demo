import PackageDescription

let package = Package(
    name: "Nifty-demo",
    dependencies: [
        .Package(url: "https://github.com/nifty-swift/Nifty.git", majorVersion: 1)
    ]    
)
