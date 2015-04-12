# ReactiveCocoaSwift
A sample app to use the latest ReactiveCocoa (3.0) in Swift. Key features are:

* Adopt UITableViewController to FRP-ish style
* Integrate ReactiveCocoa with Mantle for model layer while using couchbase-lite for persistant

**IMPORTANT:** This sample is NOT compatible to Swift 1.2 (Xcode 6.3) or later! Looks like the latest version of the ReactiveCocoa in CocoaPods doesn't support Swift 1.2 yet so until it is fixed you can't build this sample. I'm sorry :(

## Requirements
This project uses following build systems:

- Cocoapods
  - For traditional Objective-C libraries
- Carthage
  - For Swift dynamic frameworks

## How to build
First, you need to install dependent libraries by:

```
pod install
carthage install
```

then open up ReactiveCocoaSwift.xcworkspace and try building!
