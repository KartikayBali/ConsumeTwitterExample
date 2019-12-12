//
//  TextFieldTableViewCell.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 07/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

protocol TextFieldTableViewCellDelegate: class {
  func textFieldDidChangeText(_ textField: UITextField)
}

class TextFieldTableViewCell: UITableViewCell {
  
  static let CellIdentifier = "TextFieldTableViewCellIdentifier"

  @IBOutlet var headerLabel: UILabel!
  @IBOutlet var valueTextField: UITextField!
  
  weak var delegate: TextFieldTableViewCellDelegate?
  
  func setupContentView(_ labelValue: String, _ textFieldValue: String, _ textFieldPlaceholder: String) {
    headerLabel.text = labelValue
    valueTextField.text = textFieldValue
    valueTextField.placeholder = textFieldPlaceholder
  }
  
  // MARK: - IBActions
  @IBAction func textFieldDidChangeText(_ textField: UITextField) {
    delegate?.textFieldDidChangeText(textField)
  }
}

// MARK: - UITextFieldDelegate
extension TextFieldTableViewCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
