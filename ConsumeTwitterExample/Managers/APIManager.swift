//
//  APIManager.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
  static let baseURL = Bundle.main.object(forInfoDictionaryKey: "Base URL") as! String
  static let apiPrefix = "1.1/"
  static let URL = "\(baseURL)\(apiPrefix)"
  static let authorizationHeader="Authorization"
  
  class func getHeaders() -> HTTPHeaders? {
    var header: HTTPHeaders = ["Content-Type": "application/json"]
    if let token = Bundle.main.object(forInfoDictionaryKey: "Bearer token") as? String {
      header[authorizationHeader] = "Bearer " + token
    }
    
    return header
  }
  
  class func fetchTweets(callBack: @escaping (_ result: [Status]?, _ error: String?) -> Void) {
    guard let headers = getHeaders() else {
      callBack(nil, "Authentication token missing")
      return
    }

    let endpoint = "search/tweets.json"
    let params: [String: Any] = ["q": UserDataManager.shared.searchText, "result_type": UserDataManager.shared.resultType.rawValue, "count": UserDataManager.shared.resultLimit]
     
    Alamofire.request(URL + endpoint, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
      
      if let jsonD = response.result.value as? Dictionary<String, AnyObject>, let statusesD = jsonD["statuses"] as? [[String: Any]] {
        var statuses = [Status]()
        for statusD in statusesD {
          let status = Status(data: statusD)
          statuses.append(status)
        }
        
        callBack(statuses, nil)
      } else {
        callBack(nil, response.error?.localizedDescription)
      }
    }
  }
  
  class func fetchRetweetsForTweet(_ status: Status, callBack: @escaping (_ result: [Status]?, _ error: String?) -> Void) {
    guard let headers = getHeaders() else {
      callBack(nil, "Authentication token missing")
      return
    }
    
    let endpoint = "statuses/retweets/\(status.id).json"
    let params: [String: Any] = ["count": UserDataManager.shared.resultLimit]
     
    Alamofire.request(URL + endpoint, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
      
      if let jsonD = response.result.value as? [[String: Any]] {
        var statuses = [Status]()
        for statusD in jsonD {
          let status = Status(data: statusD)
          statuses.append(status)
        }
        
        callBack(statuses, nil)
      } else {
        callBack(nil, response.error?.localizedDescription)
      }
    }
  }
}
