//
//  SearchAction.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import ReSwift
import RxSwift
import Moya
import Result
import ObjectMapper

extension SearchState {
  public static func searchTweets(query: String, maxId: String? = nil) -> Store<AppState>.ActionCreator {
    return { _, _ in
      
      _ = MoyaProvider<SearchProvider>()
        .request(.searchTweets(query: query, maxId: maxId)) { event in
          switch event {
          case .success(let response):
            do {
              if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
                if let tweets: [Tweet] = Mapper<Tweet>().mapArray(JSONArray: statuses) {
                  store.dispatch(SetSearchResultsAction(results: .success(tweets)))
                } else {
                  store.dispatch(SetSearchResultsAction(results: .failure(.somethingWentWrong("Parse Error"))))
                }
              }
            } catch {
              store.dispatch(SetSearchResultsAction(results: .failure(.somethingWentWrong("Parse Error"))))
            }
            
            break
          case .failure(let error): store.dispatch(SetSearchResultsAction(results: .failure(.somethingWentWrong(error.localizedDescription))))
            break
          }
      }
      
      return nil
    }
  }
}

struct SetSearchQueryAction: Action {
  let query: String
}

struct SetSearchResultsAction: Action {
  let results: Result<[Tweet], TwitterAPIError>
}

struct SetSearchMaxIdAction: Action {
  let maxId: String
}

struct ResetSearchAction: Action {}
