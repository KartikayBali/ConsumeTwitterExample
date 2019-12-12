//
//  MediaView.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 07/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class MediaView: NibView {

  // MARK: - IBOutlets
  @IBOutlet var mediaImageView: UIImageView!
  
  // MARK: - Variables
  var media: [Media]! {
    didSet {
      loadContentView()
    }
  }
  
  // MARK: - Lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    
    mediaImageView.layer.cornerRadius = 6
  }

  // MARK: - Private Methods
  private func loadContentView() {
    mediaImageView.sd_setImage(with: URL(string: media.first!.url), completed: nil)
  }
}
