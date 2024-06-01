// swift-tools-version: 5.10

import PackageDescription

let package = Package(
  name: "ionicup-server",
  platforms: [
    .macOS(.v14),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.3.0"),
    .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-beta.5"),
    .package(url: "https://github.com/ionicup/ionicup-models", branch: "main")
  ],
  targets: [
    .executableTarget(
      name: "IonicupServer",
      dependencies: [
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "Hummingbird", package: "hummingbird"),
        .product(name: "IonicupModels", package: "ionicup-models")
      ]
    ),
//    .target(
//      name: "Ionicup",
//      dependencies: [
//        .product(
//          name: "Hummingbird",
//          package: "hummingbird"
//        ),
//        .product(
//          name: "HummingbirdFoundation",
//          package: "hummingbird"
//        ),
//      ],
//      swiftSettings: [
//        .unsafeFlags(
//          ["-cross-module-optimization"],
//          .when(configuration: .release)
//        ),
//      ]
//    ),
//    .testTarget(
//      name: "AppTests",
//      dependencies: [
//        .product(
//          name: "HummingbirdXCT",
//          package: "hummingbird"
//        ),
//        .target(name: "App"),
//      ]
//    ),
  ]
)
