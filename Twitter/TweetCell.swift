//
//  TweetCell.swift
//  Twitter
//
//  Created by Rutvij Shah on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    var tweetId: Int = -1
    
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !self.retweeted
        
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweetButton(true)
            }, failure: { (error) in
                print("Could not retweet tweet: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweetButton(false)
            }, failure: { (error) in
                print("Could not undo retweet \(error)")
            })
        }
    }
    
    @IBAction func favorite(_ sender: Any) {
        let toBeFavorited = !self.favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavoriteButton(true)
            }, failure: { (error) in
                print("error: tweet could not be favorited \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavoriteButton(false)
            }, failure: { (error) in
                print("error: tweet could not be unfavorited \(error)")
            })
        }
    }
    
    
    func setFavoriteButton(_ isFavorited: Bool) {
        self.favorited = isFavorited
        var img = "favor-icon"
        if (favorited) {
            img = "favor-icon-red"
        }
        self.favoriteButton.setImage(UIImage(named: img), for: UIControl.State.normal)
    }
    
    func setRetweetButton(_ isRetweeted: Bool) {
        self.retweeted = isRetweeted
        var img = "retweet-icon"
        if (retweeted) {
            img = "retweet-icon-green"
        }
        self.retweetButton.setImage(UIImage(named: img), for: UIControl.State.normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
