//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Vasant Saladi on 9/30/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweet: UIButton!
    
    @IBOutlet weak var favorite: UIButton!
    

    
    var favorited:Bool = false
    var tweetId:Int =  -1
    var retweeted:Bool = false
    
    
    
    @IBAction func retweetb(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Error is retweeting: \(error)")
        })
    }
    
    func setRetweeted( isRetweeted:Bool) {
        if (isRetweeted) {
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    
    func setFavorite( isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favorite.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favorite.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        } else {
            
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(isFavorited: false)
            }, failure: { (error) in
                print("UnFavorite did not succeed: \(error)")
            })
            
        }
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
