//
//  TweetDetailTableViewCell.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

protocol TweetDetailTableViewCellDelegate: class {
  func didTapOnUserImageButton(_ user: User)
}

class TweetDetailTableViewCell: UITableViewCell {
  
  static let CellIdentifier = "TweetDetailTableViewCellIdentifier"
  
  @IBOutlet var statusTextLabel: UILabel!
  @IBOutlet var dateTimeLabel: UILabel!
  @IBOutlet var userInfoView: UserInfoView!
  @IBOutlet var mediaView: MediaView!
  @IBOutlet var infoView: InfoView!
  @IBOutlet var mediaViewHeightLayoutConstraint: NSLayoutConstraint!
  
  var status: Status! {
    didSet {
      setupContentView()
    }
  }
  
  weak var delegate: TweetDetailTableViewCellDelegate?
  
  // MARK: - Private Methods
  private func setupMediaView(isHidden: Bool) {
    mediaViewHeightLayoutConstraint.constant = CGFloat(isHidden ? 0 : status.media[0].getMediaViewHeightForWidth(Float(mediaView.frame.width)))
    mediaView.isHidden = isHidden
    if !isHidden {
      mediaView.media = status.media
    }
  }
  
  private func setupContentView() {
    userInfoView.user = status.user
    userInfoView.delegate = self
    setupMediaView(isHidden: status.media.count == 0)
    statusTextLabel.text = status.text
    dateTimeLabel.text = status.createdAt.getDateStringWithFormat("h:mm a . dd/MM/yyyy")
    infoView.loadContentViewWithValues(header1: "Retweets", value1: "\(status.retweetCount)", header2: "Likes", value2: "\(status.favoriteCount)")
  }
}

// MARK: - UserInfoViewDelegate
extension TweetDetailTableViewCell: UserInfoViewDelegate {
  func didTapOnUserImageButton(_ user: User) {
    delegate?.didTapOnUserImageButton(user)
  }
}
