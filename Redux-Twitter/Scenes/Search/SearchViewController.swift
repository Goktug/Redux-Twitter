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
import ReRxSwift

class SearchViewController: UIViewController, Routable {
  
  let connection = Connection(store: store,
                              mapStateToProps: mapStateToProps,
                              mapDispatchToActions: mapDispatchToActions)
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tweetsCollectionView: UICollectionView!
  
  private var results: [Tweet] = []
  private var didChangeQuery: PublishSubject = PublishSubject<Void>()
  private var didChangeMaxId: PublishSubject = PublishSubject<Void>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
    configurePullToRefresh()
    
    // When query or maxId changes, it is gonna reload data only once
    // this mechanism prevents reloading twice
    Observable.combineLatest(didChangeQuery, didChangeMaxId)
      .subscribe(onNext: { [weak self] _ in
        self?.updateData()
      })
      .disposed(by: disposeBag)
    
    connection.subscribe(\Props.query) { [weak self] query in
      self?.didChangeQuery.onNext(())
    }
    
    connection.subscribe(\Props.maxId) { [weak self] maxId in
      // do nil check for preventing in order to reloading twice
      if maxId != nil {
        self?.didChangeMaxId.onNext(())
      }
    }
    
    searchBar.rx.text
      .orEmpty // Make it non-optional
      .skip(1)
      .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] text in
        if text != "" {
          self?.actions.searchTweets(text)
        } else {
          self?.actions.resetSearch()
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func updateData() {
    if let results = store.state.searchState.results {
      switch results {
      case let .success(tweets):
        self.results = tweets
        break
      case let .failure(TwitterAPIError.somethingWentWrong(error)):
        print("Error: \(error)")
        self.results.removeAll()
        break
      }
      
      self.tweetsCollectionView.reloadData()
    } else {
      // Reset
      self.results.removeAll()
      self.tweetsCollectionView.reloadData()
    }
    
    self.tweetsCollectionView.switchRefreshFooter(to: .normal)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    connection.connect()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if store.state.navigationState.route != [RouteNames.search] {
      actions.setRoute([RouteNames.search])
      updateData()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    connection.disconnect()
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
}

extension SearchViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let tweet = results[indexPath.item]
    
    actions.setTweetDetail(tweet)
    actions.setRoute([RouteNames.search, RouteNames.tweetDetail])
  }
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

extension SearchViewController: Connectable {
  struct Props {
    let query: String?
    let maxId: String?
  }
  struct Actions {
    let searchTweets: (_ query: String) -> ()
    let loadMoreTweets: () -> ()
    let resetSearch: () -> ()
    let setTweetDetail: (_ tweet: Tweet) -> ()
    let setRoute: (Route) -> ()
  }
}

private let mapStateToProps = { (appState: AppState) in
  return SearchViewController.Props(
    query: appState.searchState.query,
    maxId: appState.searchState.maxId
  )
}

private let mapDispatchToActions = { (dispatch: @escaping DispatchFunction) in
  return SearchViewController.Actions(
    searchTweets: { newQuery in dispatch(SearchState.searchTweets(query: newQuery)) },
    loadMoreTweets: { dispatch(SearchState.loadMoreTweets()) },
    resetSearch: { dispatch(ResetSearchAction()) },
    setTweetDetail: { tweet in dispatch(SetTweetDetailAction(tweet: tweet)) },
    setRoute: { route in dispatch(ReSwiftRouter.SetRouteAction(route)) }
  )
}
