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
import RxCocoa
import RxSwift
import Result
import PullToRefreshKit

class SearchViewController: UIViewController, StoreSubscriber, Routable {
  typealias StoreSubscriberStateType = SearchState
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tweetsCollectionView: UICollectionView!
  
  private var results: [Tweet] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configurePullToRefresh()
    
    searchBar.rx.text
      .orEmpty // Make it non-optional
      .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
      .distinctUntilChanged()
      .subscribe(onNext: { text in
        if text != "" {
          store.dispatch(SearchState.searchTweets(query: text))
        } else {
          store.dispatch(ResetSearchAction())
        }
      })
      .disposed(by: disposeBag)
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
  
  private func configurePullToRefresh() {
    let footer = DefaultRefreshFooter.footer()
    
    tweetsCollectionView.configRefreshFooter(with: footer, action: { [weak self] in
      self?.loadMore()
    })
  }
  
  private func loadMore() {
    tweetsCollectionView.switchRefreshFooter(to: .refreshing)
    store.dispatch(SearchState.loadMoreTweets())
  }
  
  func newState(state: SearchState) {
    if let results = state.results {
      switch results {
      case let .success(tweets):
        self.results = tweets
        break
      case let .failure(TwitterAPIError.somethingWentWrong(error)):
        print("Error: \(error)")
        self.results.removeAll()
        break
      }
      
      tweetsCollectionView.reloadData()
    } else {
      // Reset
      self.results.removeAll()
      tweetsCollectionView.reloadData()
    }
    
    tweetsCollectionView.switchRefreshFooter(to: .normal)
  }
}

extension SearchViewController: UICollectionViewDelegate {
  
}

extension SearchViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let tweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.tweetCell.identifier, for: indexPath) as? TweetCell {
      
      tweetCell.model = results[indexPath.row]
      
      return tweetCell
    }
    
    return UICollectionViewCell()
  }
}
