# Veeather

## Project

Application supports **iOS 10.0** or higher and every compatible iPhone.
It was written to show some concepts of clean swift and dependency injection in practice

## Tools & Requirements

Project is written in **Swift 5.0** and requires the following tools to be installed:

- **[Xcode](https://github.com/KrauseFx/xcode-install) 11** using the latest **iOS 13 SDK**,
- **[Carthage](https://github.com/Carthage/Carthage) 0.27** or higher,
- **[CocoaPods](https://github.com/CocoaPods/CocoaPods) 1.5.3** or higher,
- **[CocoaPods-Keys](https://github.com/orta/cocoapods-keys) 2.0.3** or higher.

## Configuration

Assuming the above requirements are met and the repository is cloned:

1. Create appropriate `.env` (or copy `.env.example`) file into the project's directory, which contains `APIToken` that will be used in to establish proper connection with API.

```swift
APIToken=YOUR_API_TOKEN
```

2. Install CocoaPods keys:

```sh
$ pod install
```

3. Install Carthage dependencies:

```sh
$ carthage bootstrap --platform iOS --cache-builds
```
4. Open `Veeather.xcodeproj` file.

5. Voila!
