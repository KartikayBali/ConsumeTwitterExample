//
//  FeedTableViewCell.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit
import SDWebImage

protocol FeedTableViewCellDelegate: class {
  func didTapOnUserButton(_ user: User)
}

class FeedTableViewCell: UITableViewCell {
  
  static let CellIdentifier = "FeedTableViewCellIdentifier"
  
  @IBOutlet var userImageButton: UIButton!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var screenNameLabel: UILabel!
  @IBOutlet var statusTextLabel: UILabel!
  
  var status: Status! {
    didSet {
      setupContentView()
    }
  }
  
  weak var delegate: FeedTableViewCellDelegate?
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    userImageButton.layer.cornerRadius = userImageButton.frame.width / 2
    userImageButton.layer.borderWidth = 1.0
    userImageButton.layer.borderColor = UIColor.white.cgColor
  }
  
  // MARK: - IBActions
  @IBAction func userImageButtonTapped(_ button: UIButton) {
    delegate?.didTapOnUserButton(status.user)
  }
  
  // MARK: - PrivateMethods
  private func setupContentView() {
    userImageButton.sd_setImage(with: URL(string: status.user.profileImageURL), for: .normal, completed: nil)
    nameLabel.text = status.user.name
    screenNameLabel.text = "@\(status.user.screenName)"
    statusTextLabel.text = status.text
  }
}
