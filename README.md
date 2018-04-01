# Redux-Twitter
Basic Twitter Implementation with ReSwift

<img src="https://cdn.pbrd.co/images/HeF4FnN.png" width="317">

# Build

To build:

1. Create an OAuth Twitter application on apps.twitter.com
2. Set your `Consumer Key` and `Consumer Secret` in `TwitterCredentials.swift` file
3. Open `TwitterCredentials.swift` and enter the `Consumer Key` and  the `Consumer Secret` of your Twitter application:
```
//  TwitterCredentials.swift
import Foundation
let twitterConsumerKey: String = ""
let twitterConsumerSecret: String = ""

```
4. Set the Twitter URL scheme of your Twitter application like `twitterkit-<your-consumer-key>` in `info.plist`
5. Run following commands.

    ```
    $ pod install
    $ carthage bootstrap --no-use-binaries --platform ios
    ```

6. Open `Redux-Twitter.xcworkspace` in Xcode.

## Dependencies
- [ReSwift](https://github.com/ReSwift/ReSwift)
- [ReSwift-Router](https://github.com/ReSwift/ReSwift-Router)
- [ReRxSwift](https://github.com/svdo/ReRxSwift)
- [RxSwift](https://github.com/ReactiveX/RxSwift)
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [Moya](https://github.com/Moya/Moya)
- [R.swift](https://github.com/mac-cain13/R.swift)
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)
- [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)
- [SnapKit](https://github.com/SnapKit/SnapKit)
- [PullToRefreshKit](https://github.com/LeoMobileDeveloper/PullToRefreshKit)
- [TwitterKit](https://github.com/twitter/twitter-kit-ios)
- [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)


## Requirements

-   iOS 9.0+
-   Swift 4.0+
