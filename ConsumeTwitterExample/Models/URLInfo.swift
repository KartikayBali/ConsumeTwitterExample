//
//  URLInfo.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

struct URLInfo {
  var url: String
  var indices: (Int, Int)
  
  init(data: [String: Any]) {
    url = data["url"] as? String ?? ""
    if let values = data["indices"] as? [Int] {
      indices = (values[0], values[1])
    } else {
      indices = (0, 0)
    }
  }
}
