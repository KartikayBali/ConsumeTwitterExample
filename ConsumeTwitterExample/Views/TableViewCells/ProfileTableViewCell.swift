//
//  ProfileTableViewCell.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
  
  static let CellIdentifier = "ProfileTableViewCellIdentifier"

  // MARK: - IBOutlets
  @IBOutlet var userInfoView: UserInfoView!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var createdAt: UILabel!
  @IBOutlet var infoView: InfoView!
  
  // MARK: - Variables
  var user: User! {
    didSet {
      loadContentView()
    }
  }
  
  // MARK: - Private Methods
  private func loadContentView() {
    userInfoView.user = user
    descriptionLabel.text = user.description
    createdAt.text = "Joined " + user.createdAt.getDateStringWithFormat("MMMM d, yyyy")
    infoView.loadContentViewWithValues(header1: "Following", value1: "\(user.friendsCount)", header2: "Followers", value2: "\(user.followersCount)")
  }
}
