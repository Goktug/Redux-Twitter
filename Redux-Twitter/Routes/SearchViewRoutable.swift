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
      let tweetDetailController = R.storyboard.tweetDetail.instantiateInitialViewController()!
      
      (viewController as! UINavigationController).pushViewController(tweetDetailController, animated: animated)
      
      return TweetDetailViewRoutable()
    }
    
    fatalError("Cannot handle this route change!")
  }
  
  public func popRouteSegment(
    _ routeElementIdentifier: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) {
    
    store.dispatch(SetTweetDetailAction(tweet: nil))
  }
  
  public func changeRouteSegment(
    _ from: RouteElementIdentifier,
    to: RouteElementIdentifier,
    animated: Bool,
    completionHandler: @escaping RoutingCompletionHandler) -> Routable {
    
    return SearchViewRoutable(viewController)
  }
}
