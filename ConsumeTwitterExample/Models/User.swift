//
//  User.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

struct User {
  var id: Int
  var name: String
  var screenName: String
  var description: String
  var followersCount: Int
  var friendsCount: Int
  var verified: Bool
  var profileImageURL: String
  var createdAt: Date
  
  init(data: [String: Any]) {
    id = data["id"] as? Int ?? -1
    name = data["name"] as? String ?? ""
    screenName = data["screen_name"] as? String ?? ""
    description = data["description"] as? String ?? ""
    followersCount = data["followers_count"] as? Int ?? 0
    friendsCount = data["friends_count"] as? Int ?? 0
    verified = data["verified"] as? Bool ?? false
    profileImageURL = data["profile_image_url_https"] as? String ?? ""
    createdAt = data["created_at"] as? Date ?? Date()
  }
}
