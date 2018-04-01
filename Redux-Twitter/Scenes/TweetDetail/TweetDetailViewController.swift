//
//  TweetDetailViewController.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class TweetDetailViewController: UIViewController, StoreSubscriber, Routable {
  
  typealias StoreSubscriberStateType = TweetDetailState
  
  @IBOutlet weak var thumbnailView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var tweetImageView: UIImageView!
  
  @IBOutlet weak var dateLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    store.subscribe(self) {
      $0.select {
        $0.tweetDetail
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    store.unsubscribe(self)
  }
  
  func newState(state: TweetDetailState) {
    if let tweet = state.tweet {
      if let imageUrl = URL(string: tweet.thumbnailUrl) {
        thumbnailView.kf.setImage(with: imageUrl)
      }
      
      if let tweetImageUrl = tweet.tweetImageUrl, let imageUrl = URL(string: tweetImageUrl) {
        tweetImageView.kf.setImage(with: imageUrl)
      }
      
      nameLabel.text = tweet.username
      messageLabel.text = tweet.text
      dateLabel.text = tweet.readableCreatedAt
    }
  }
}
