//
//  PerfectlyCraftedTabBarViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class PerfectlyCraftedTabBarViewController: UITabBarController {
    
    private let persistenceController: PersistenceController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.6722700215, green: 1, blue: 0.6019102933, alpha: 1)
        setUpTabbarItems()
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTabbarItems(){
        let feedsViewController = UIStoryboard(name: "Feeds", bundle: Bundle.main).instantiateViewController(identifier: "PostViewController", creator: { coder in
            return PostViewController(coder: coder, persistenceController: self.persistenceController)
        })
        let newsFeedNavigationController = UINavigationController(rootViewController: feedsViewController)
        
        feedsViewController.tabBarItem.image = #imageLiteral(resourceName: "icons8-hashtag-activity-feed-25")
        feedsViewController.title = "News Feed"
       
        self.viewControllers = [newsFeedNavigationController]
        
    }
    
}
