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
      DispatchQueue.main.async {
        self.feedsView.feedsCollectionView.reloadData()
      }
    }
  }
  private var userSession: UserSession!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    view.addSubview(feedsView)
    setUpDelegates()
    getTheNewsFeeds()
  }
  
  private func setUpDelegates(){
    self.userSession = AppDelegate.theUser
    feedsView.feedsCollectionView.delegate = self
    feedsView.feedsCollectionView.dataSource = self
  }
  private func getTheNewsFeeds(){
    DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.feed).getDocuments { (snapshot, error) in
      if let error = error{
        print(error)
      }
      else if let snapshot = snapshot{
        snapshot.documents.forEach{
          let results =  $0.data()
          let feed = FeedModel.init(dict: results)
          self.userFeed.append(feed)
        }
      }
    }
  }
  private func setImageOnButton(button:UIButton,urlString:String){
    if let image = ImageCache.shared.fetchImageFromCache(urlString: urlString){
      DispatchQueue.main.async {
        button.setImage(image, for: .normal)
      }
    }else{
      ImageCache.shared.fetchImageFromNetwork(urlString: urlString) { (error, image) in
        if let error = error{
          print(error)
        }else if let image = image{
          DispatchQueue.main.async {
            button.setImage(image, for: .normal)
          }
        }
      }
    }
  }
  
}
extension FeedsViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 400, height:600)
  }
  
}
extension FeedsViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userFeed.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedsView.feedsCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCell", for: indexPath) as? FeedsCollectionViewCell else {fatalError("No feed cell was found")}
    let feed = userFeed[indexPath.row]
    getImage(ImageView: cell.postImage, imageURLString: feed.imageURL)
    cell.userName.text = feed.userName
    cell.captionLabel.text = feed.caption
    setImageOnButton(button: cell.profileImage, urlString: feed.userImageLink)
    return cell
    
  }
}
