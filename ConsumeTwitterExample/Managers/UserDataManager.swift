//
//  UserDataManager.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

enum ResultType: String {
  case Mixed = "mixed"
  case Recent = "recent"
  case Popular = "popular"
  
  static let AllResultTypes = [Mixed, Recent, Popular]
}

class UserDataManager {
  static let shared = UserDataManager()
  static let defaultSearchText = "twitter"
  static let resultPagesLimit = [10, 25, 50, 75, 100]
  
  var resultType = ResultType.AllResultTypes.last!
  var resultLimit = UserDataManager.resultPagesLimit.first!
  var searchText = UserDataManager.defaultSearchText
}
