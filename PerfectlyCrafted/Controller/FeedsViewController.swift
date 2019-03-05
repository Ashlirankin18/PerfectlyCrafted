//
//  FeedsViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController {

  let feedsView = FeedsView()
  private var userFeed = [FeedModel](){
    didSet{
      print("i am set user feed. I have \(userFeed.count) item ")
    }
  }
  private var userSession: UserSession!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
      view.addSubview(feedsView)
      feedsView.feedsCollectionView.delegate = self
      feedsView.feedsCollectionView.dataSource = self
      self.userSession = AppDelegate.theUser
    }
    

  
}
extension FeedsViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 400, height:600)
  }

}
extension FeedsViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  guard let cell = feedsView.feedsCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCell", for: indexPath) as? FeedsCollectionViewCell else {fatalError("No feed cell was found")}
    
      return cell
    
  }
}
