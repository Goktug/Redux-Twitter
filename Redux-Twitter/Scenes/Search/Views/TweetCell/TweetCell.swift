//
//  TweetCell.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit
import Kingfisher

class TweetCell: UICollectionViewCell {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var thumbnailView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var tweetImageView: UIImageView!
  
  @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
  
  var model: Tweet? {
    didSet {
      if let model = model {
        if let imageUrl = URL(string: model.thumbnailUrl) {
          thumbnailView.kf.setImage(with: imageUrl)
        }
        
        if let tweetImageUrl = model.tweetImageUrl, let imageUrl = URL(string: tweetImageUrl) {
          tweetImageView.kf.setImage(with: imageUrl)
        }
        
        nameLabel.text = model.username
        messageLabel.text = model.text
        dateLabel.text = model.readableCreatedAt
      }
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    thumbnailView.image = nil
    tweetImageView.image = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    translatesAutoresizingMaskIntoConstraints = false
    containerViewWidthConstraint.constant = Sizes.screenWidth
  }
}
