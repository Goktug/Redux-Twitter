//
//  SplashViewController.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit
import TwitterKit
import ReSwift
import ReSwiftRouter

class SplashViewController: UIViewController, StoreSubscriber, Routable {
  typealias StoreSubscriberStateType = AuthState

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    store.subscribe(self) {
      $0.select {
        $0.authState
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    if store.state.authState.loggedInState == .idle {
      store.dispatch(AuthState.authenticateUser())
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    store.unsubscribe(self)
  }
  
  func newState(state: AuthState) {
    if state.loggedInState == .notLoggedIn {
      
      let alert = UIAlertController(title: "Error", message: state.error!.localizedDescription, preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { _ in
        store.dispatch(AuthState.authenticateUser())
      }))
      
      present(alert, animated: true)
    }
  }
}
