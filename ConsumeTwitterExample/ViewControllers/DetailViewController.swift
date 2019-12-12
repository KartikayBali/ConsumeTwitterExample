//
//  DetailViewController.swift
//  ConsumeTwitterExample
//
//  Created by Bali on 06/12/19.
//  Copyright © 2019 Kartikay Bali. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet var tableView: UITableView!
  
  // MARK: - Variables
  var status: Status!
  var retweets = [Status]()
  
  // MARK:- Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Detail"
    setupTableView()
    if status.retweetCount > 0 {
      fetchRetweets()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    if let viewController = segue.destination as? ProfileViewController, let user = sender as? User {
      viewController.user = user
    }
  }
  
  // MARK:- Private Methods
  private func setupTableView() {
    let nib = UINib(nibName: TweetDetailTableViewCell.self.description().components(separatedBy: ".").last!, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TweetDetailTableViewCell.CellIdentifier)
    
    let nib2 = UINib(nibName: FeedTableViewCell.self.description().components(separatedBy: ".").last!, bundle: nil)
    tableView.register(nib2, forCellReuseIdentifier: FeedTableViewCell.CellIdentifier)
  }

  private func fetchRetweets() {
    APIManager.fetchRetweetsForTweet(status) { (result, error) in
      if let errorMessage = error {
        print(errorMessage)
        return
      }
      
      if let statuses = result {
        self.retweets = statuses
        self.tableView.reloadData()
      }
    }
  }
}

// MARK:- UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return retweets.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: TweetDetailTableViewCell.CellIdentifier) as! TweetDetailTableViewCell
      cell.status = status
      cell.delegate = self
      return cell
      
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.CellIdentifier) as! FeedTableViewCell
      cell.status = retweets[indexPath.row - 1]
      cell.delegate = self
      cell.selectionStyle = .none
      return cell
    }
  }
}

// MARK: - TweetDetailTableViewCellDelegate
extension DetailViewController: TweetDetailTableViewCellDelegate {
  func didTapOnUserImageButton(_ user: User) {
    performSegue(withIdentifier: "DetailToProfileSegueIdentifier", sender: user)
  }
}

// MARK: - FeedTableViewCellDelegate
extension DetailViewController: FeedTableViewCellDelegate {
  func didTapOnUserButton(_ user: User) {
    performSegue(withIdentifier: "DetailToProfileSegueIdentifier", sender: user)
  }
}
