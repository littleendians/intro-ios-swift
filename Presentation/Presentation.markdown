theme: Plain Jane, 2
footer: © Little Endian, 2018
slidenumbers: false

# **Introduction to iOS**
## using Swift

---
# Jens Nerup
## [@barkoded](https://twitter.com/barkoded) at Twitter

---
# Prerequisite
## **You'll need a Mac capable of running latest version of Xcode**

---
# Agenda

* Swift & iOS Platform
* Cocoa Design Patterns
* Application Launch
* View Controller
* Lets get started...

---
# Swift & the iOS Platform

---
# Swift
* Publicly announced during WWDC 2014 - June 2014
* Version 1.0 released with iOS 8 on **September 17, 2014**
* Latest version (4.0.3) released on **December 5, 2017**
* Builds on the best of C and Objective-C and many other languages
* Seamless access to all existing Cocoa frameworks

---
# Swift
* Safe programming patterns and "modern" features
* Mix-and-match interoperability with C and Objective-C
* Reference types (classes & closures) and value types (structures & enumerations)
* Actively developed by Apple Inc. and others
* Open Source - http://swift.org & https://github.com/apple/swift

---
# Swift - Memory

* __A__utomatic __R__eference __C__ounting aka __ARC__
* [Reference counting applies only to instances of classes](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html
).
* Watch out for *Retain Cycles* and *[Closure captures](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID103)*

---
# iOS - App, Graphics & Games Frameworks
* __App Frameworks__
Objective-C, Swift Standard Library, Foundation, UIKit
* __Graphics and Games Frameworks__
Metal, Core Graphics, GLKit, ...

---
# iOS - App Services, Media and Web Frameworks
* __App Services__
MapKit, Core Location, Core Data, ...
* __Media and Web__
AVKit, WebKit, Safari Services, ...

^ For more details on the APIs available on the platform please check out this [API Reference](https://developer.apple.com/reference).

---
# Essential Cocoa Design Patterns

---
# Essential Cocoa Design Patterns
## **3 essential patterns**
* Model View Controller - MVC
* Delegate Pattern
* Notification (Observer Pattern)

---
# Model View Controller
![inline 100%](assets/MVC.pdf)

---
# Delegate in Cocoa
__Purpose__: _Object expresses certain behaviour to the outside but in reality delegates responsibility for implementing that behaviour to an associated object_.

• Defined using a __protocol__
• Defining both required and __optional__ methods.
• Mostly assigned on the delegating __class__

---
# Delegate
```swift
protocol PlaygroundServiceDelegate: class {
  func didUpdate(playground: Playground)
}

class PlaygroundService {
...
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
![inline 100%](assets/Notification.pdf)

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

![inline 80%](assets/ApplicationLaunch.pdf)

---
# View Controller

---
# View Controller
> ... manages a set of views that make up a portion of your app’s user interface. It is responsible for loading and disposing of those views, for managing interactions with those views, and for coordinating responses with any appropriate data objects. View controllers also coordinate their efforts with other controller objects—including other view controllers—and help manage your app’s overall interface.

---
# Root View Controller
* The _RootViewController_ set on __UIApplication__ via your __UIApplicationDelegate__
* Each __UIViewController__ has an associated __UIView__ (with zero or more children - the view hierarchy)
* Defines the initial visual starting point

![right 75%](assets/ViewController_1.pdf)

---
# Content View Controller
* Presents content on the screen
* Should be reusable and self-contained entities.
* Knows of the model layer and manages the view hierarchy. Common tasks:
  * Show data to the user (e.g. details)
  * Collect data from the user (e.g. forms)
  * Perform a specific task

---
# Massive View Controller
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
##Separate concerns to:
* Avoid becoming the place for all tasks
* Help you maintain readability, maintainability, and testability.

---
# The Lighter View Controller

##Easy steps:
* Separate the __datasources__ and __delegates__ from the __ViewController__
* Move networking to separate classes
* Move domain display formatting to separate classes - presenters/view-model.
* Use categories on e.g. cells to set domain information.

---
# Lets get started...

![30%](assets/demo1.png)
![30%](assets/demo2.png)
![30%](assets/demo3.png)

---
# Resources

---
# Online

* [The Swift Programming Language (Swift 4.0.3)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)
* [Intro to App Development with Swift](https://itunes.apple.com/dk/book/intro-to-app-development-with-swift/id1118575552?mt=11) (iBooks)
* [App Development with Swift](https://itunes.apple.com/dk/book/app-development-with-swift/id1219117996?mt=11) (iBooks)
* [API Reference](https://developer.apple.com/reference)
* [Swift Playgrounds for iPad](https://www.apple.com/swift/playgrounds/)
* [This week in Swift](https://swiftnews.curated.co) (newsletter)
* [iOS Dev Weekly](https://iosdevweekly.com) (newsletter)

---
# Online - continued

* [8 Patterns to Help You Destroy Massive View Controller](http://khanlou.com/2014/09/8-patterns-to-help-you-destroy-massive-view-controller/)
* [SOLID](https://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29)
* [Swift Package Manager](https://swift.org/package-manager/) - Package Manager
* [Cocoapods](https://cocoapods.org) - Package Manager
* [Carthage](https://github.com/Carthage/Carthage) - Package Manager

---
# Offline

* [__iOS Programming: The Big Nerd Ranch Guide 5th Edition__
by Christian Keur and Aaron Hillegass](https://www.amazon.co.uk/gp/product/0321942051/ref=pd_sim_14_2?ie=UTF8&psc=1&refRID=9EEFD1RZJCBQ8WA562S8)
* [__Programming in Objective-C__
by Stephen Kochan](https://www.amazon.co.uk/Programming-Objective-C-Developers-Library-Stephen/dp/0321967607/ref=sr_1_1?ie=UTF8&qid=1479728446&sr=8-1&keywords=Programming+in+Objective-C)
* [__The C Programming Language (2nd Edition)__
by Brian W. Kernighan and Dennis Ritchie](https://www.amazon.co.uk/C-Programming-Language-2nd/dp/0131103628/ref=sr_1_1?ie=UTF8&qid=1479728508&sr=8-1&keywords=The+C+Programming+Language+%282nd+Edition%29)

---
# Selected Extra Tools

* [AppCode](https://www.jetbrains.com/objc/)
Alternative IDE to Xcode but not a full replacement yet.
* [Kaleidoscope](http://www.kaleidoscopeapp.com)
Great diff and merge tool.
* [GitUp](http://gitup.co) - (free)
Superb Mac git client.
* [Tower](https://www.git-tower.com/mac/)
Another great commercial git client for the Mac.

---
# Selected Extra Tools

* [SimPholders](https://simpholders.com)
A lovely little tool to manage your simulators.
* [Charles Proxy](https://www.charlesproxy.com)
When working with REST API's this is a must as a proxy.
* [Paw](https://paw.cloud)
Working with REST API? Then consider this to explore the API.
* [Sketch](https://www.sketchapp.com)
Vector graphics editor - alternative to Adobe Illustrator.

---
![inline 100%](assets/littleendianlogo.pdf)
