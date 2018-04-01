# Redux-Twitter
Basic Twitter Implementation with ReSwift and RxSwift

<img src="https://cdn.pbrd.co/images/HeF4FnN.png" width="317">

# Build

To build:

1. Create an OAuth Twitter application from [https://apps.twitter.com](https://apps.twitter.com)
2. Open `TwitterCredentials.swift` and enter the `Consumer Key` and  the `Consumer Secret` of your Twitter application:
```
//  TwitterCredentials.swift
import Foundation
let twitterConsumerKey: String = ""
let twitterConsumerSecret: String = ""

```
3. Set the Twitter URL scheme of your Twitter application like `twitterkit-<your-consumer-key>` in `info.plist`
4. Run following commands.

    ```
    $ pod install
    ```

5. Open `Redux-Twitter.xcworkspace` in Xcode.

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
