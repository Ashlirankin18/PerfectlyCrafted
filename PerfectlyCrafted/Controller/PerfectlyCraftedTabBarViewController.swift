//
//  PerfectlyCraftedTabBarViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PerfectlyCraftedTabBarViewController: UITabBarController {
  
  var user: User?
  
  override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = #colorLiteral(red: 0.6722700215, green: 1, blue: 0.6019102933, alpha: 1)
    let feedsViewController = FeedsViewController()
    let profileViewController = ProfileViewController.init(user: user, view: ProfileView())
    let navigationController = UINavigationController(rootViewController: profileViewController)
    let newsFeedNavigationController = UINavigationController(rootViewController: feedsViewController)
    let createPostViewController = CreatPostViewController()
    let ratingViewController = RatingViewController()
    let ratingNavigation = UINavigationController(rootViewController: ratingViewController)
    let createNavigation = UINavigationController(rootViewController: createPostViewController)
    feedsViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-news-feed-25")
    feedsViewController.title = "News Feed"
    profileViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-user-26")
    profileViewController.title = "Profile"
    createPostViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-plus-math-25")
    createPostViewController.title = "Create"
    ratingViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-popular-25")
    ratingViewController.title = "Reviews"
    self.viewControllers = [newsFeedNavigationController,ratingNavigation,createNavigation,navigationController]
    
    }
    

    
}
