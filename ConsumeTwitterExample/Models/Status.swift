//
//  Status.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

struct Status {
  var id: Int
  var createdAt: Date
  var text: String
  var retweetCount: Int
  var favoriteCount: Int
  var user: User
  var media: [Media]
  var urls: [URLInfo]
  
  init(data: [String: Any]) {
    id = data["id"] as? Int ?? -1
    createdAt = data["created_at"] as? Date ?? Date()
    text = data["text"] as? String ?? ""
    retweetCount = data["retweet_count"] as? Int ?? 0
    favoriteCount = data["favorite_count"] as? Int ?? 0
    if let userD = data["user"] as? [String: Any] {
      user = User(data: userD)
    } else {
      user = User(data: [:])
    }
    
    media = [Media]()
    urls = [URLInfo]()
    if let entitiesD = data["entities"] as? [String: Any] {
      if let mediaD = entitiesD["media"] as? [[String: Any]] {
        for data in mediaD {
          let m = Media(data: data)
          media.append(m)
        }
      }
      
      if let urlD = entitiesD["urls"] as? [[String: Any]] {
        for data in urlD {
          let u = URLInfo(data: data)
          urls.append(u)
        }
      }
    }
  }
}
