//
//  MyPostViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/8/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class MyPostViewController: UIViewController {

  let feedView = FeedsView()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      view.addSubview(feedView)
      feedView.feedsCollectionView.dataSource = self
      feedView.feedsCollectionView.delegate = self
      self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
    }
  
  @objc func backButtonPressed(){
    dismiss(animated: true, completion: nil)
  }

}
extension MyPostViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = feedView.feedsCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedsCell", for: indexPath) as? FeedsCollectionViewCell else {fatalError("no feed cell was found")}
    return cell
  }
  
  
}
extension MyPostViewController:UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: 400, height: 600)
  }
}
