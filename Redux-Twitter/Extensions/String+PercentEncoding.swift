//
//  String+PercentEncoding.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String {
    let unreserved = "-._~"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    
    if let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet) {
      return encodedString
    }
    
    return self
  }
}
