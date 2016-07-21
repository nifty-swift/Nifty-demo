import PackageDescription

let package = Package(
    name: "NiftyDemo", 
    dependencies: [
        .Package(url: "https://github.com/philipce/nifty.git", majorVersion: 1)
    ]
)
