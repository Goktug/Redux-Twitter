//
//  Tweet.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import ObjectMapper

class Tweet: Mappable {
  var username: String!
  var thumbnailUrl: String!
  var createdAt: String!
  var text: String!
  var tweetImageUrl: String?
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    username <- map["user.screen_name"]
    text <- map["text"]
    thumbnailUrl <- map["user.profile_image_url"]
  }
}
