//
//  SearchReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift

func searchReducer(action: Action, state: SearchState?) -> SearchState {
  var state = state ?? SearchState()
  
  switch action {
  case let action as SetSearchResultsAction:
    state.results = action.results
  case let action as SetSearchQueryAction:
    state.query = action.query
  case let action as SetSearchMaxIdAction:
    state.maxId = action.maxId
  case _ as ResetSearchAction:
    state.query = nil
    state.results = nil
    state.maxId = nil
  default:
    break
  }
  
  return state
}
