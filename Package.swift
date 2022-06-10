// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Far",
    
    platforms: [
        .macOS(.v10_15),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)],
    
    products: [
        .library(name: "Far", targets: ["Far"])
    ],
    
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.0"))
    ],
    
    targets: [
        .target(name: "Far",
                dependencies: ["Alamofire"],
                path: "Sources",
                linkerSettings: [.linkedFramework("Foundation", .when(platforms: [.iOS, .macOS, .tvOS, .watchOS]))]),
        
        .testTarget(name: "FarTests",
                    dependencies: ["Far", "Alamofire"],
                    path: "Tests")
    ]
)
