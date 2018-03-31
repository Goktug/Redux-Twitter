//
//  SearchViewRoutable.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwiftRouter

class SearchViewRoutable: Routable {
  
  let viewController: UIViewController
  
  init(_ viewController: UIViewController) {
    self.viewController = viewController
  }
  
  func pushRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    
    if routeElementIdentifier == RouteNames.tweetDetail {
      
      let tweetDetailViewController = R.storyboard.tweetDetail.instantiateInitialViewController()!
      
      (self.viewController as! UINavigationController).pushViewController(
        tweetDetailViewController,
        animated: true
      )
      
      return TweetDetailViewRoutable()
    }
    
    fatalError("Cannot handle this route change!")
  }
}
