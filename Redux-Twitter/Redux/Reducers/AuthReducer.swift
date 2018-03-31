//
//  AuthReducer.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift

func authReducer(action: Action, state: AuthState?) -> AuthState {
  var state = state ?? AuthState()
  
  switch action {
  case let action as LoadAuthAction:
    state.session = action.session
    state.error = nil
    state.loggedInState = .loggedIn
  case let action as ErrorAuthAction:
    state.session = nil
    state.error = action.error
    state.loggedInState = .notLoggedIn
  default:
    break
  }
  
  return state
}
