//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Rutvij Shah on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweet()
    }
    
    func loadTweet() {
        
        let userTimelineUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let urlParams = ["count": 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(
            url: userTimelineUrl,
            parameters: urlParams,
            success: { (tweets: [NSDictionary]) in
                self.tweetArray.removeAll()
                for tweet in tweets {
                    self.tweetArray.append(tweet)
                }
                self.tableView.reloadData()
            },
            failure: { (error) in
                print("Couldn't retrieve tweets! \(error)")
            })
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        
        cell.tweetContentLabel.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavoriteButton(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweetButton(tweetArray[indexPath.row]["retweeted"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArray.count
    }
}
