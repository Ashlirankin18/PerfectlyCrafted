//
//  PerfectlyCraftedTabBarViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PerfectlyCraftedTabBarViewController: UITabBarController {
  
  var allHairProducts = [AllHairProducts]()
  var theLocalUser:UserModel?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 0.6722700215, green: 1, blue: 0.6019102933, alpha: 1)
    getAllHairProducts()
    setUpTabbarItems()
    }


  private func setUpTabbarItems(){
    let feedsViewController = FeedsViewController()
    let profileViewController = ProfileViewController.init(view: ProfileView())
    let profileNavigationController = UINavigationController(rootViewController: profileViewController)
    let newsFeedNavigationController = UINavigationController(rootViewController: feedsViewController)
    let searchViewController = SearchProductViewController()
    let searchNavigationController = UINavigationController(rootViewController: searchViewController)
    let myProductViewController = UIStoryboard.init(name: "ProfileOptions", bundle: nil).instantiateViewController(withIdentifier: "HairProductsTableViewController")
    feedsViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-hashtag-activity-feed-25")
    feedsViewController.title = "News Feed"
    profileViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-user-26")
    profileViewController.title = "Profile"
    searchViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-search-25")
    searchViewController.title = "Search"
    myProductViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-spray-filled-25.png")
      myProductViewController.title = "My Products"
    
    self.viewControllers = [newsFeedNavigationController,searchNavigationController,myProductViewController, profileNavigationController]
    
  }
  private func getAllHairProducts(){
    HairProductApiClient.getHairProducts { (error, allHairProducts) in
      if let error = error {
        print(error.errorMessage())
      }
      if let allHairProducts = allHairProducts{
    ProductDataManager.setProducts(products: allHairProducts)
      }
    }
  }
    
}
