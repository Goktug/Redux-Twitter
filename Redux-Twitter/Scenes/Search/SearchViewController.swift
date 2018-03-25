//
//  SearchViewController.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tweetsCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  private func configureCollectionView() {
    tweetsCollectionView.register(R.nib.tweetCell(), forCellWithReuseIdentifier: R.reuseIdentifier.tweetCell.identifier)
    if let flowLayout = tweetsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      if #available(iOS 10.0, *) {
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
      }
      else {
        flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
      }
      
    }
    tweetsCollectionView.delegate = self
    tweetsCollectionView.dataSource = self
  }
}

extension SearchViewController: UICollectionViewDelegate {
  
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let tweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.tweetCell.identifier, for: indexPath) as? TweetCell {
      return tweetCell
    }
    
    return UICollectionViewCell()
  }
}
