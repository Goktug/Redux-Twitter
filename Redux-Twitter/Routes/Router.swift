//
//  Router.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift
import ReSwiftRouter

var router: Router<AppState>!

struct RouteNames {
  static let splash = "Splash"
  static let search = "Search"
  static let tweetDetail = "TweetDetail"
}
