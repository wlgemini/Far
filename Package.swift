// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Far",
    
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)],
    
    products: [
        .library(name: "Far", targets: ["Far"])
    ],
    
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.0"))
    ],
    
    targets: [
        .target(name: "Far",
                dependencies: ["Alamofire"],
                linkerSettings: [.linkedFramework("Foundation", .when(platforms: [.iOS, .macOS, .tvOS, .watchOS]))]),
        
        .testTarget(name: "FarTests",
                    dependencies: ["Far", "Alamofire"],
                    path: "Tests")
    ]
)
