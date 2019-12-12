//
//  SettingsViewController.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 07/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

enum SettingsSections: String {
  case SearchText = "Search Text"
  case ResultType = "Result Type"
  case ResultLimit = "Result limit"
}

protocol SettingsViewControllerDelegate: class {
  func didSavedSettings()
}

class SettingsViewController: UIViewController {
  
  let sections: [SettingsSections] = [.SearchText, .ResultType, .ResultLimit]
  
  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Variables
  var searchText = UserDataManager.shared.searchText
  var resultType = UserDataManager.shared.resultType
  var resultLimit = UserDataManager.shared.resultLimit
  
  weak var delegate: SettingsViewControllerDelegate?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
    setupTableView()
  }
  
  // MARK: - Private Methods
  private func setupTableView() {
    let nib = UINib(nibName: TextFieldTableViewCell.self.description().components(separatedBy: ".").last!, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TextFieldTableViewCell.CellIdentifier)
  }
  
  private func setupNavigationBar() {
    navigationItem.title = "Settings"
    
    let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped(_:)))
    navigationItem.leftBarButtonItem = leftBarButtonItem
    
    let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped(_:)))
    navigationItem.rightBarButtonItem = rightBarButtonItem
  }
  
  @objc private func cancelButtonTapped(_ button: UIBarButtonItem) {
    if UserDataManager.shared.searchText == searchText && UserDataManager.shared.resultType == resultType && UserDataManager.shared.resultLimit == resultLimit {
      navigationController?.popViewController(animated: true)
    } else {
      let alertController = UIAlertController(title: "Warning!", message: "You are about to lose data. Do you wish to continue?", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
        self.navigationController?.popViewController(animated: true)
      }
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(okAction)
      alertController.addAction(cancelAction)
      present(alertController, animated: true, completion: nil)
    }
  }
  
  @objc private func saveButtonTapped(_ button: UIBarButtonItem) {
    UserDataManager.shared.searchText = searchText
    UserDataManager.shared.resultType = resultType
    UserDataManager.shared.resultLimit = resultLimit
    
    delegate?.didSavedSettings()
  }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if sections[indexPath.section] == .SearchText {
      let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.CellIdentifier) as! TextFieldTableViewCell
      cell.delegate = self
      cell.setupContentView(sections[indexPath.section].rawValue, searchText, UserDataManager.defaultSearchText)
      return cell
    }
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier")
    if cell == nil {
      cell = UITableViewCell(style: .value1, reuseIdentifier: "CellIdentifier")
    }
    
    cell!.textLabel?.text = sections[indexPath.section].rawValue
    cell!.accessoryType = .disclosureIndicator
    
    switch sections[indexPath.section] {
    case .ResultType:
      cell!.detailTextLabel?.text = resultType.rawValue
    case .ResultLimit:
      cell!.detailTextLabel?.text = "\(resultLimit)"
    default:
      break
    }
    
    return cell!
  }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if sections[indexPath.section] == .SearchText, let cell = tableView.cellForRow(at: indexPath) as? TextFieldTableViewCell {
      cell.valueTextField.becomeFirstResponder()
      return
    }
    
    let actionViewController = UIAlertController(title: sections[indexPath.section].rawValue, message: nil, preferredStyle: .actionSheet)
    if sections[indexPath.section] == .ResultType {
      for resultType in ResultType.AllResultTypes {
        let action = UIAlertAction(title: resultType.rawValue, style: .default) { (_) in
          self.resultType = resultType
          self.tableView.reloadSections([indexPath.section], with: .automatic)
        }
        actionViewController.addAction(action)
      }
    } else if sections[indexPath.section] == .ResultLimit {
      for page in UserDataManager.resultPagesLimit {
        let action = UIAlertAction(title: "\(page)", style: .default) { (_) in
          self.resultLimit = page
          self.tableView.reloadSections([indexPath.section], with: .automatic)
        }
        actionViewController.addAction(action)
      }
    }
    
    actionViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(actionViewController, animated: true, completion: nil)
  }
}

// MARK:- TextFieldTableViewCellDelegate
extension SettingsViewController: TextFieldTableViewCellDelegate {
  func textFieldDidChangeText(_ textField: UITextField) {
    if let text = textField.text, text.count > 0 {
      searchText = text
    } else {
      searchText = UserDataManager.defaultSearchText
    }
  }
}
