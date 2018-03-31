//
//  Errors.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation

enum TwitterAPIError: Error {
  case somethingWentWrong(String)
}
