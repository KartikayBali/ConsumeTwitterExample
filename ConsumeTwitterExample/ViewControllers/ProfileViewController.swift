//
//  ProfileViewController.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 08/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Variables
  var user: User!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }
  
  // MARK: - Private Methods
  private func setupTableView() {
    let nib = UINib(nibName: ProfileTableViewCell.self.description().components(separatedBy: ".").last!, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: ProfileTableViewCell.CellIdentifier)
  }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.CellIdentifier) as! ProfileTableViewCell
    cell.user = user
    return cell
  }
}
