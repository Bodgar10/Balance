// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Balance",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Balance",
            targets: ["Balance"]),
    ],
    dependencies: [.package(url: "https://github.com/Bodgar10/DesignSystem.git", .upToNextMajor(from: "1.0.2"))],
    targets: [
        .target(
            name: "Balance", dependencies: [.product(name: "DesignSystem", package: "DesignSystem")]),
        .testTarget(
            name: "BalanceTests",
            dependencies: ["Balance"]),
    ],
    swiftLanguageVersions: [.v5]
)