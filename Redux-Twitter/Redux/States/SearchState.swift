//
//  SearchState.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import Result
import ReSwift

struct SearchState: StateType, Encodable {
  var query: String?
  var results: Result<[Tweet], TwitterAPIError>?
  var maxId: String?
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(results, forKey: .results)
    try container.encode(maxId, forKey: .maxId)
  }
  
  private enum CodingKeys: String, CodingKey {
    case query
    case results
    case maxId
  }
}
