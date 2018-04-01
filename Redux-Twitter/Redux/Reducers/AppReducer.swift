//
//  AppReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
  return AppState(
    authState: authReducer(action: action, state: state?.authState),
    navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
    searchState: searchReducer(action: action, state: state?.searchState),
    tweetDetail: tweetDetailReducer(action: action, state: state?.tweetDetail)
  )
}
