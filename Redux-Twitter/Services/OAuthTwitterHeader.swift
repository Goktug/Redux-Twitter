//
//  OAuthTwitterHeader
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 31.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import Foundation
import CryptoSwift

class OAuthTwitterHeader {
  private var httpMethod: String
  private var url: String
  private var requestParameters: [String: Any]
  private var oAuthParameters: [String: Any] = [:]
  
  init(method: String, url: String, requestParameters: [String: Any]) {
    self.httpMethod = method
    self.url = url
    self.requestParameters = requestParameters
    
    generateOAuthParameters()
    generateOAuthSignature()
  }
  
  func getData() -> String {
    var data: String = "OAuth "
    
    let lastParameterOffset = oAuthParameters.count - 1
    for (offset: i, element: (key: key, value: value)) in oAuthParameters.enumerated() {
      if i != lastParameterOffset {
        data += "\(key)=\"\(value)\", "
      } else {
        data += "\(key)=\"\(value)\""
      }
    }
    
    return data
  }
  
  private func generateOAuthParameters() {
    oAuthParameters["oauth_consumer_key"] = twitterConsumerKey.stringByAddingPercentEncodingForRFC3986()
    oAuthParameters["oauth_nonce"] = UUID().uuidString.stringByAddingPercentEncodingForRFC3986()
    oAuthParameters["oauth_signature_method"] = "HMAC-SHA1"
    oAuthParameters["oauth_timestamp"] = "\(Int(Date().timeIntervalSince1970))"
    
    if let session = store.state.authState.session {
      oAuthParameters["oauth_token"] = session.authToken.stringByAddingPercentEncodingForRFC3986()
    }
    
    oAuthParameters["oauth_version"] = "1.0"
  }
  
  private func generateOAuthSignature() {
    let oauthSignatureBase: String = generateSignatureBase()
    let oauthSignatureSecret: String = generateSignatureSecret()
    
    if let digest = try? HMAC(key: oauthSignatureSecret, variant: .sha1).authenticate(oauthSignatureBase.bytes) {
      if let digestBase64 = digest.toBase64() {
        oAuthParameters["oauth_signature"] = digestBase64.stringByAddingPercentEncodingForRFC3986()
      }
    }
  }
  
  private func generateSignatureBase() -> String {
    var parameters = [String: Any]()
    
    for (k, v) in oAuthParameters { parameters[k] = v }
    for (k, v) in requestParameters { parameters[k] = v }
    
    var entries = [String]()
    let keys = parameters.keys.sorted(by: { $0.lowercased() < $1.lowercased() })
    for key: String in keys {
      if let obj = parameters[key] as? String {
        let entry = "\(key.stringByAddingPercentEncodingForRFC3986())=\(obj.stringByAddingPercentEncodingForRFC3986())"
        entries.append(entry)
      }
    }
    
    let normalizedParameters = entries.joined(separator: "&").stringByAddingPercentEncodingForRFC3986()
    
    let signatureBase = [
      httpMethod.stringByAddingPercentEncodingForRFC3986(),
      url.stringByAddingPercentEncodingForRFC3986(),
      normalizedParameters
    ].joined(separator: "&")
    
    return signatureBase
  }
  
  private func generateSignatureSecret() -> String {
    guard let session = store.state.authState.session else { return "" }
    
    let tokenSecret = session.authTokenSecret.stringByAddingPercentEncodingForRFC3986()
    
    return  "\(twitterConsumerSecret.stringByAddingPercentEncodingForRFC3986())&\(tokenSecret)"
  }
}
