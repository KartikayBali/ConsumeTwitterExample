//
//  InfoView.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class InfoView: NibView {
  
  @IBOutlet var headerLabel1: UILabel!
  @IBOutlet var valueLabel1: UILabel!
  @IBOutlet var headerLabel2: UILabel!
  @IBOutlet var valueLabel2: UILabel!

  func loadContentViewWithValues(header1: String, value1: String, header2: String, value2: String) {
    headerLabel1.text = header1
    valueLabel1.text = value1
    headerLabel2.text = header2
    valueLabel2.text = value2
  }
}
