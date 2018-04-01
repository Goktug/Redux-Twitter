//
//  SearchReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift
import Result

func searchReducer(action: Action, state: SearchState?) -> SearchState {
  var state = state ?? SearchState()
  
  switch action {
  case let action as SearchTweetsAction:
    state.results = action.results
    state.maxId = action.maxId
    state.query = action.query
  case let action as LoadMoreTweetsAction:
    state.maxId = action.maxId
    
    switch action.results {
    case let .success(tweets):
      if var currentTweets = state.results!.value {
        currentTweets.append(contentsOf: tweets)
        
        state.results = .success(currentTweets)
      }
      break
    case .failure(_):
      state.results = action.results
      break
    }
    break
  case _ as ResetSearchAction:
    state.query = nil
    state.results = nil
    state.maxId = nil
  default:
    break
  }
  
  return state
}
