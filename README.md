A simple composer sheet for Twitter written in Swift. For the sake of learning Swift, Auto Layout, and Unit testing with XCTest.

To use the composer:

```swift
let composer = DLFComposeViewController()
composer.delegate = self
composer.topMargin = 40
composer.modalPresentationStyle = UIModalPresentationStyle.Custom
self.presentViewController(composer, animated: true, completion: nil)
```

![Screenshot](https://raw.githubusercontent.com/nicnocquee/ComposerSheet/master/screenshot.png)
