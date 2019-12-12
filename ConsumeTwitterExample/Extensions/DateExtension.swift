//
//  DateExtension.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 07/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import Foundation

extension Date {
  
  func getDateStringWithFormat(_ dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: self)
  }
}
