//
//  NibView.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//
//  Reference: https://medium.com/swift2go/swift-custom-uiview-with-xib-file-211bb8bbd6eb

import UIKit

class NibView: UIView {
  
  var view: UIView!
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    xibSetup()
  }
  
  private func xibSetup() {
    backgroundColor = UIColor.clear
    view = loadNib()
    // use bounds not frame or it'll be offset
    view.frame = bounds
    // Adding custom subview on top of our view
    addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([view.widthAnchor.constraint(equalTo: widthAnchor), view.heightAnchor.constraint(equalTo: heightAnchor)])
  }
}
