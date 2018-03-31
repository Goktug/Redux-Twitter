//
//  SearchProvider.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import Moya

enum SearchProvider : TargetType {
  case searchTweets(query: String, maxId: String?)
  
  var baseURL: URL { return URL(string: "https://api.twitter.com/1.1")! }
  
  var path: String {
    switch self {
    case .searchTweets(_, _):
      return "/search/tweets.json"
    }
  }
  var method: Moya.Method {
    switch self {
    case .searchTweets(_, _):
      return .get
    }
  }
  
  var sampleData: Data { return Data() }
  
  var task: Task {
    switch self {
    case .searchTweets(let query, let maxId):
      var parameters: [String: Any] = ["q" : query]
      if maxId != nil {
        parameters["max_id"] = maxId!
      }
      
      return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    let url: String = "\(baseURL)\(self.path)"
    var requestParameters: [String: Any] = [:]
    
    switch self.task {
    case let .requestParameters(parameters, _):
      requestParameters = parameters
      break
    default:
      break
    }
    
    let twitterHeader = OAuthTwitterHeader(method: method.rawValue, url: url, requestParameters: requestParameters)
    
    return ["Authorization": twitterHeader.getData()]
  }
}

