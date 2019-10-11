theme: Plain Jane, 2
footer: © 2019 Little Endian & MAKE//CPH
slidenumbers: false

# **Introduction to iPhone Apps using Swift**

## October 2019

---

# Jens Nerup

## [@barkoded](https://twitter.com/barkoded) at Twitter
## [jens@makecph.com](jens@makecph.com)

---

# Prerequisite

## **You'll need a Mac capable of running latest version of Xcode**

---

# Agenda

* Languages & Platform
* Cocoa Design Patterns
* View Controller
* Application Launch
* Lets get started...
* Resources

---

# Languages & Platform

---

# Apple Supported Languages

|     |    Swift   |   Objective C   |
| ----------- | :-----------: | :-----------: |
| Typing discipline |    Static, Strong, Inferred    |    Static, Dynamic, Weak    |
| Influenced by |   Objective-C, Rust, Haskell, Ruby, Python, C#...    |   C, Smalltalk   |
| Paradigm | Multi-paradigm[^1] | Reflective, class-based object-oriented |
| First appeared |   2014    |   1984   |
| Popularization |   Apple    |   NeXT   |

[^1]:Protocol-oriented, object-oriented, functional, imperative, block structured

---

# Objective-C

* Thin layer atop C, and is a "strict superset" of C
* All of the syntax for non-object-oriented operations are identical to those of C
* All of the object-oriented features is an implementation of Smalltalk-style messaging.
* Objective-C++ files are denoted with a .mm file extension. (Combination of C++ and Objective-C syntax)

^ "strict superset" = possible to compile any C program with an Objective-C compiler, and to freely include C language code within an Objective-C class.
^ non-object-oriented operations: primitive variables, pre-processing, expressions, function declarations, and function calls
^ implementation program files usually have .m filename extensions, while Objective-C 'header/interface' files have .h extensions (like C)

---

# Objective-C - continued

* Blocks is a nonstandard extension for Objective-C that uses special syntax to create closures[^2].
* Usable through out all the platforms - macOS, iOS, iPadOS, watchOS and tvOS.
* Caution - As of iOS 13 some frameworks are only available using Swift.

[^2]: A syntax that is very hard to remember unless you work with it every day http://goshdarnblocksyntax.com

---

# Swift

* Publicly announced during WWDC 2014 - June 2014
* Version 1.0 released with iOS 8 on **September 17, 2014**
* Latest version (5.1) released on **September 19, 2019**
* Builds on the best of C and Objective-C and many other languages
* Seamless access to all existing Cocoa frameworks

---

# Swift - continued

* Safe programming patterns and "modern" features
* Mix-and-match interoperability with C and Objective-C (but not C++)
* Reference types (classes & closures) and value types (structures & enumerations)
* Actively developed by Apple Inc. and others
* Open Source - http://swift.org & https://github.com/apple/swift

---

# User Interface Frameworks

|     |    UIKit   |   SwiftUI   |
| ----------- | :-----------: | :-----------: |
| Language    |    Swift, Objective C   |   Swift   |
| Platforms    |    iOS/iPadOS/watchOS/tvOS   |   All (incl. macOS)   |
| Stable    |    Yes   |   Kind of stable  |
| Type    |     Imperative[^3]   |   Declarative  |

[^3]: Mostly works on delegates and callback blocks

---

# Additional App, Graphics & Games Frameworks

* __App Frameworks__
Swift Standard Library, Foundation, UIKit
* __Graphics and Games Frameworks__
Metal, Core Graphics, GLKit, ...

---

# Additional App Services, Media and Web Frameworks

* __App Services__
MapKit, Core Location, Core Data, ...
* __Media and Web__
AVKit, WebKit, Safari Services, ...

^ For more details on the APIs available on the platform please check out this [API Reference](https://developer.apple.com/reference).

---

# Cocoa Design Patterns

---

# 3 Essential Design Patterns

* Model View Controller - MVC
* Delegate Pattern
* Notification (Observer Pattern)

---

# Model View Controller

![inline 100%](Assets/MVC.pdf)

---

# Delegate in Cocoa

__Purpose__: _Object expresses certain behaviour to the outside but in reality delegates responsibility for implementing that behaviour to an associated object_.

• Defined using a __protocol__
• Defining both required and __optional__ methods. If Swift only protocol then __optional__ isn't supported
• Mostly assigned on the delegating __class__

---

# Delegate

```swift
protocol PlaygroundServiceDelegate: class {
  func didUpdate(playground: Playground)
}

class PlaygroundService {
...
// The delegate should always be weak for class protocols to avoid retain cycles
weak var delegate: PlaygroundServiceDelegate?
...
}

```

---

# Cocoa Delegate Naming

* Usually include on of three verbs: __should__, __will__ or __did__
* __should__ methods should return a value.
* __will__ and __did__ are not expected to return values
* __will__ and __did__ are primary informative before and after an occurrence - _think of it as a one to one notification_.

---

# Notification

![inline 100%](Assets/Notification.pdf)

---

# UIViewController

---

# View Controller

> ... manages a set of views that make up a portion of your app’s user interface. It is responsible for loading and disposing of those views, for managing interactions with those views, and for coordinating responses with any appropriate data objects. View controllers also coordinate their efforts with other controller objects—including other view controllers—and help manage your app’s overall interface.

---

# Root View Controller

* The _RootViewController_ set on __UIApplication__ via your __UIApplicationDelegate__
* Each __UIViewController__ has an associated __UIView__ (with zero or more children - the view hierarchy)
* Defines the initial visual starting point

![right 75%](Assets/ViewController_1.pdf)

---

# "Content" View Controller

* Presents content on the screen
* Should be reusable and self-contained entities.
* Knows of the model layer and manages the view hierarchy. Common tasks:
  * Show data to the user (e.g. details)
  * Collect data from the user (e.g. forms)
  * Perform a specific task

---

# MVC ≠ Massive View Controller

## Should be avoided. Use the [SOLID](https://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29) principal

^ S: a class should have only a single responsibility
^ O: open for extension, but closed for modification
^ L: objects should be replaceable with instances of their subtypes without altering the correctness of that program.
^ I: many client-specific interfaces are better than one general-purpose interface.
^ D: one should “Depend upon Abstractions. Do not depend upon concretions.

---

# SOLID

* __S__: a class should have only a single responsibility
* __O__: open for extension, but closed for modification
* __L__: objects should be replaceable with instances of their subtypes
* __I__: many client-specific interfaces are better than one general-purpose interface.
* __D__: one should “Depend upon Abstractions. Do not depend upon concretions.

---

# The Light View Controller

## Separate concerns to:

* Avoid becoming the place for all tasks
* Help you maintain readability, maintainability, and testability.

---

# The Lighter View Controller

## Easy steps:

* Separate the __datasources__ and __delegates__ from the __ViewController__
* Move networking to separate classes
* Move domain display formatting to separate classes - presenters/view-model.
* Use categories on e.g. cells to set domain information - try to make 'em fileprivate.

---

# Application Launch

---

# What to Do at Launch Time

* Check the contents of the launch options dictionary for information about why the app was launched, and respond appropriately.
* Initialise the app’s most critical data structures.
* Prepare your app’s window and views for display.
* Be as lightweight as possible to reduce your app’s launch time.
* Start handling events in less than 5 seconds

---

![inline 80%](Assets/ApplicationLaunch.pdf)

---

# Lets get started...

![30%](Assets/demo1.png)
![30%](Assets/demo2.png)
![30%](Assets/demo3.png)

---

# Resources

---

# Online

* [Source code for this presentation](https://github.com/littleendians/intro-ios-swift)
* [The Swift Programming Language - Swift 5.1](https://docs.swift.org/swift-book/)
* [Developing iOS 10 Apps with Swift](https://itunes.apple.com/us/course/developing-ios-10-apps-with-swift/id1198467120)
* [API Reference](https://developer.apple.com/reference)
* [SwiftUI](https://developer.apple.com/xcode/swiftui/)
* [Swift Playgrounds for iPad](https://www.apple.com/swift/playgrounds/)
* [iOS Dev Weekly](https://iosdevweekly.com) (newsletter)

---

# Online - continued

* [Hacking With Swift](https://www.hackingwithswift.com)
* [8 Patterns to Help You Destroy Massive View Controller](http://khanlou.com/2014/09/8-patterns-to-help-you-destroy-massive-view-controller/)
* [Swift Package Manager](https://swift.org/package-manager/) - Official Swift Package Manager
* [Cocoapods](https://cocoapods.org) - Open Source Package Manager
* [Carthage](https://github.com/Carthage/Carthage) - Open Source Package Manager

---

# Oldies but Goodies

* [__The C Programming Language (2nd Edition)__
by Brian W. Kernighan and Dennis Ritchie](https://www.amazon.co.uk/C-Programming-Language-2nd/dp/0131103628/ref=sr_1_1?ie=UTF8&qid=1479728508&sr=8-1&keywords=The+C+Programming+Language+%282nd+Edition%29)
* [__Programming in Objective-C__
by Stephen Kochan](https://www.amazon.co.uk/Programming-Objective-C-Developers-Library-Stephen/dp/0321967607/ref=sr_1_1?ie=UTF8&qid=1479728446&sr=8-1&keywords=Programming+in+Objective-C)

---

# Selected Extra Tools

* [AppCode](https://www.jetbrains.com/objc/)
Alternative IDE to Xcode but not a full replacement yet.
* [Kaleidoscope](http://www.kaleidoscopeapp.com)
Great diff and merge tool but sadly not in active development.
* [Tower](https://www.git-tower.com/mac/)
Superb commercial = git client.
* [GitUp](http://gitup.co) - (free)
Another great open source git client for the Mac.

---

# Selected Extra Tools - continued

* [SimPholders](https://simpholders.com)
A lovely little tool to manage your simulators.
* [Charles Proxy](https://www.charlesproxy.com)
When working with REST API's this is a must as a proxy.
* [Paw](https://paw.cloud)
Working with REST API? Then consider this to explore the API.
* [Sketch](https://www.sketchapp.com)
Vector graphics editor - suberb alternative to Adobe Illustrator.
