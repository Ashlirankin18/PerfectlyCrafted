//
//  ProfileViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

  var user: User?
  var profileView = ProfileView()
  
  init(user:User?,view:ProfileView) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
    self.profileView = view
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    view.addSubview(profileView)
      profileView.profileCollectionView.delegate = self
    profileView.profileCollectionView.dataSource = self
       view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    }
    

    
}
extension ProfileViewController:UICollectionViewDelegateFlowLayout{
 
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 250, height: 500)
  }
}
extension ProfileViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = profileView.profileCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as? ProfileCollectionViewCell else {fatalError("No cell could be dequeue")}
    return cell
  }
  
}
