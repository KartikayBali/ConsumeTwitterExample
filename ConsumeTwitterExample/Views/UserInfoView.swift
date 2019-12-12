//
//  UserInfoView.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

protocol UserInfoViewDelegate: class {
  func didTapOnUserImageButton(_ user: User)
}

class UserInfoView: NibView {

  // MARK: - IBOutlets
  @IBOutlet var userImageButton: UIButton!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var screenNameLabel: UILabel!

  // MARK: - Variables
  var user: User! {
    didSet {
      loadContentView()
    }
  }
  
  weak var delegate: UserInfoViewDelegate?
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    userImageButton.layer.cornerRadius = userImageButton.frame.height / 2
    userImageButton.layer.borderWidth = 1.0
    userImageButton.layer.borderColor = UIColor.white.cgColor
  }
  
  // MARK: - IBActions
  @IBAction func userImageButtonTapped(_ button: UIButton) {
    delegate?.didTapOnUserImageButton(user)
  }
  
  // MARK: - Private Methods
  private func loadContentView() {
    userImageButton.sd_setImage(with: URL(string: user.profileImageURL), for: .normal, completed: nil)
    nameLabel.text = user.name
    screenNameLabel.text = "@\(user.screenName)"
  }
}
