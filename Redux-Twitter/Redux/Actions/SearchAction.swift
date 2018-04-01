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
  public static func searchTweets(query: String) -> Store<AppState>.ActionCreator {
    return { _, _ in
      
      _ = MoyaProvider<SearchProvider>()
        .request(.searchTweets(query: query, maxId: nil)) { event in
          switch event {
          case .success(let response):
            do {
              if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
                let tweets = Mapper<Tweet>().mapArray(JSONArray: statuses)
                var resultsMaxId: String? = nil
                if let lastTweet = tweets.last {
                  resultsMaxId = lastTweet.id
                }
                
                store.dispatch(SearchTweetsAction(query: query, results: .success(tweets), maxId: resultsMaxId))
              }
            } catch {
              store.dispatch(SearchTweetsAction(query: query, results: .failure(.somethingWentWrong("Parse Error")), maxId: nil))
            }
            
            break
          case .failure(let error): store.dispatch(SearchTweetsAction(query: query, results: .failure(.somethingWentWrong(error.localizedDescription)), maxId: nil))
            break
          }
      }
      
      return nil
    }
  }
  
  public static func loadMoreTweets() -> Store<AppState>.ActionCreator {
    return { state, _ in
      
      guard let query = state.searchState.query, let maxId = state.searchState.maxId else { return nil }
      
      _ = MoyaProvider<SearchProvider>()
        .request(.searchTweets(query: query, maxId: maxId)) { event in
          switch event {
          case .success(let response):
            do {
              if let json = try response.mapJSON() as? [String: Any], let statuses = json["statuses"] as? [[String : Any]] {
                
                let tweets = Mapper<Tweet>().mapArray(JSONArray: statuses)
                var newMaxId: String? = nil
                if let lastTweet = tweets.last {
                  newMaxId = lastTweet.id
                }
                
                store.dispatch(LoadMoreTweetsAction(results: .success(tweets), maxId: newMaxId))
              }
            } catch {
              store.dispatch(LoadMoreTweetsAction(results: .failure(.somethingWentWrong("Parse Error")), maxId: maxId))
            }
            
            break
          case .failure(let error): store.dispatch(LoadMoreTweetsAction(results: .failure(.somethingWentWrong(error.localizedDescription)), maxId: maxId))
            break
          }
      }
      
      return nil
    }
  }
}

struct SearchTweetsAction: Action {
  let query: String
  let results: Result<[Tweet], TwitterAPIError>
  let maxId: String?
}

struct LoadMoreTweetsAction: Action {
  let results: Result<[Tweet], TwitterAPIError>
  let maxId: String?
}

struct ResetSearchAction: Action {}
