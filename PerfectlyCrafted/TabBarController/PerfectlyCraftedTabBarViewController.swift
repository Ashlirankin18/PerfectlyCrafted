//
//  PerfectlyCraftedTabBarViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/5/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

final class PerfectlyCraftedTabBarViewController: UITabBarController {
    
    private let persistenceController: PersistenceController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbarItems()
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTabbarItems() {
        let feedsViewController = UIStoryboard(name: "Feeds", bundle: Bundle.main).instantiateViewController(identifier: "PostViewController", creator: { coder in
            return PostViewController(coder: coder, persistenceController: self.persistenceController)
        })
        let newsFeedNavigationController = UINavigationController(rootViewController: feedsViewController)
        tabBar.tintColor = .black
        feedsViewController.tabBarItem.image = UIImage(systemName: "doc.fill") ?? UIImage()
        self.viewControllers = [newsFeedNavigationController]
    }
}
