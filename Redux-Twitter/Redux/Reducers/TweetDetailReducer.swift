//
//  TweetDetailReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 1.04.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift

func tweetDetailReducer(action: Action, state: TweetDetailState?) -> TweetDetailState {
  var state = state ?? TweetDetailState()
  
  switch action {
  case let action as SetTweetDetailAction:
    state.tweet = action.tweet
  default:
    break
  }
  
  return state
}
