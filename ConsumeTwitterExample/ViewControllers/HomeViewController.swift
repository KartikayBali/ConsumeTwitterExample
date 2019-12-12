//
//  HomeViewController.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Variables
  var statuses = [Status]()

  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
   
    setupNavigationBar()
    setupTableView()
    fetchTweets()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: nil)
    
    if let viewController = segue.destination as? DetailViewController, let status = sender as? Status {
      viewController.status = status
    } else if let viewController = segue.destination as? SettingsViewController {
      viewController.delegate = self
    } else if let viewController = segue.destination as? ProfileViewController, let user = sender as? User {
      viewController.user = user
    }
  }
  
  // MARK:- Private Methods
  @objc private func settingsButtonTapped(_ button: UIBarButtonItem) {
    performSegue(withIdentifier: "HomeToSettingsSegueIdentifier", sender: nil)
  }
  
  private func setupNavigationBar() {
    navigationItem.title = "Home"
    let settingsBarButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped(_:)))
    navigationItem.rightBarButtonItem = settingsBarButton
  }
  
  private func setupTableView() {
    let nib = UINib(nibName: FeedTableViewCell.self.description().components(separatedBy: ".").last!, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: FeedTableViewCell.CellIdentifier)
  }

  private func fetchTweets() {
    APIManager.fetchTweets { (result, error) in
      if let errorMessage = error {
        print(errorMessage)
        return
      }
      
      if let statuses = result {
        self.statuses = statuses
        self.tableView.reloadData()
      }
    }
  }
}

// MARK:- UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return statuses.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.CellIdentifier) as! FeedTableViewCell
    cell.status = statuses[indexPath.row]
    cell.delegate = self
    return cell
  }
}

// MARK:- UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    performSegue(withIdentifier: "HomeToDetailSegueIdentifier", sender: statuses[indexPath.row])
  }
}

// MARK: - SettingsViewControllerDelegate
extension HomeViewController: SettingsViewControllerDelegate {
  func didSavedSettings() {
    navigationController?.popViewController(animated: true)
    
    fetchTweets()
  }
}

// MARK: - FeedTableViewCellDelegate
extension HomeViewController: FeedTableViewCellDelegate {
  func didTapOnUserButton(_ user: User) {
    performSegue(withIdentifier: "HomeToProfileSegueIdentifier", sender: user)
  }
}
