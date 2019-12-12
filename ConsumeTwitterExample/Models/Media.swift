//
//  Media.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 07/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

enum MediaType: String {
  case Photo = "photo"
  case Unknown = "unknown"
}

struct Media {
  var id: Int
  var url: String
  var type: MediaType
  var aspectRatio: Float
  
  init(data: [String: Any]) {
    id = data["id"] as? Int ?? -1
    url = data["media_url_https"] as? String ?? ""
    if let t = data["type"] as? String, t != MediaType.Photo.rawValue {
      type = .Unknown
    } else {
      type = .Photo
    }
    
    if let sizes = data["sizes"] as? [String: Any], let medium = sizes["medium"] as? [String: Any], let width = medium["w"] as? Float, let height = medium["h"] as? Float {
      aspectRatio = height / width
    } else {
      aspectRatio = 1
    }
  }
  
  func getMediaViewHeightForWidth(_ width: Float) -> Float {
    return aspectRatio * width
  }
}
