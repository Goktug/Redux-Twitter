//
//  SearchViewController.swift
//  Redux-Twitter
//
//  Created by Göktuğ Gümüş on 25.03.2018.
//  Copyright © 2018 Goktug Gumus. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter
import RxSwift

//
import Result
import Moya

class SearchViewController: UIViewController, StoreSubscriber, Routable {
  typealias StoreSubscriberStateType = SearchState
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tweetsCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    store.subscribe(self) {
      $0.select {
        $0.searchState
      }
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    store.unsubscribe(self)
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
  
  func newState(state: SearchState) {
    
    if let results = state.results {
      switch results {
      case let .success(tweets):
        print(tweets.toJSON())
        break
      case let .failure(TwitterAPIError.somethingWentWrong(error)):
        print("Error: \(error)")
        break
      }
    }
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
