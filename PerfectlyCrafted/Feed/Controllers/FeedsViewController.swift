//
//  FeedsViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import Kingfisher

class FeedsViewController: UIViewController {
    @IBOutlet private weak var feedsCollectionView: UICollectionView!
    
    private var userFeed = [FeedModel](){
        didSet{
            DispatchQueue.main.async {
                self.feedsCollectionView.reloadData()
                self.userFeed.sort{$0.datePosted > $1.datePosted}
            }
        }
    }
    private var userSession: UserSession!
    private var appUser: UserModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setUpDelegates()
        getTheNewsFeeds()
        setUserProfile()
        
    }
    
    private func setUpDelegates(){
        self.userSession = AppDelegate.theUser
        feedsCollectionView.delegate = self
        feedsCollectionView.dataSource = self
    }
    
    private func getTheNewsFeeds(){
        DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.feed).addSnapshotListener { [weak self] (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let snapshot = snapshot{
                self?.userFeed.removeAll()
                snapshot.documents.forEach {
                    let results = $0.data()
                    let feed = FeedModel.init(dict: results)
                    self?.userFeed.append(feed)
                }
            }
        }
    }
    
    private func setUserProfile(){
        if let user = userSession.getCurrentUser(){
            
            _ = DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.users).document(user.uid).addSnapshotListener { [weak self] (snapshot, error) in
                if let error = error{
                    print(error.localizedDescription)
                }
                else if let snapshot = snapshot{
                    guard let userData = snapshot.data() else {return}
                    let profileUser = UserModel.init(dict: userData)
                    
                    self?.appUser = profileUser
                }
            }
        }else{
            print("no user logged in")
        }
    }
    
}


extension FeedsViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 400, height:550)
    }
    
}
extension FeedsViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedsCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCell", for: indexPath) as? FeedsCollectionViewCell else {fatalError("No feed cell was found")}
        let feed = userFeed[indexPath.row]
        cell.userName.text = feed.userName
        cell.captionLabel.text = "\(feed.caption)"
        cell.dateLabel.text = "\(feed.datePosted)"
        let posrUrl = URL(string: feed.imageURL)
        let placeholder = #imageLiteral(resourceName: "placeholder.png")
        cell.postImage.kf.setImage(with: posrUrl,placeholder:placeholder)
        if appUser.userId == feed.userId {
            if let userURL = appUser.profileImageLink{
                cell.profileImage.kf.setImage(with: URL(string: userURL), for: .normal,placeholder:#imageLiteral(resourceName: "placeholder.png"))
            }
        } else {
            cell.profileImage.kf.setImage(with: URL(string: feed.userImageLink), for: .normal,placeholder:#imageLiteral(resourceName: "placeholder.png"))
        }
        return cell
    }
}
