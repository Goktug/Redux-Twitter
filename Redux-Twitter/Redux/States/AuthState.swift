//
//  AuthState.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import TwitterKit
import ReSwift

struct AuthState: StateType {
  var session: TWTRAuthSession?
  var error: NSError?
  var loggedInState: LoggedInState = .idle
}

enum LoggedInState {
  case idle
  case notLoggedIn
  case loggedIn
}
