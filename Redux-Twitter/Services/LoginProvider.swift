//
//  LoginProvider.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import TwitterKit

class LoginProvider {
  
  static func loginWithTwitter(completion: @escaping TWTRLogInCompletion) {
    TWTRTwitter.sharedInstance().logIn(completion: completion)
  }
  
  static func getLastSession() -> TWTRAuthSession? {
    let store = TWTRTwitter.sharedInstance().sessionStore
    
    return store.session()
  }
  
  static func logOut() {
    let store = TWTRTwitter.sharedInstance().sessionStore
    
    if let userID = store.session()?.userID {
      store.logOutUserID(userID)
    }
  }
}
