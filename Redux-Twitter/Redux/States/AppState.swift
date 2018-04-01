//
//  AppState.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType {
  var authState: AuthState = AuthState()
  var navigationState: NavigationState
  var searchState: SearchState = SearchState()
  var tweetDetail: TweetDetailState = TweetDetailState()
}
