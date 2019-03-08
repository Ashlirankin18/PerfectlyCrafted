//
//  SearchView.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/20/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SearchView: UIView {

  lazy var productSearchBar:UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.barStyle = .default
    searchBar.placeholder = "search product name"
    searchBar.showsCancelButton = true
    return searchBar
  }()
  lazy var productsTableView:UITableView = {
    let tableView = UITableView()
    tableView.register(ProductDisplayCell.self, forCellReuseIdentifier: "DisplayCell")
    return tableView
  }()
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit(){
    setUpViews()
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
}
extension SearchView {
  func setUpViews(){
    setUpSearchBarConstraints()
    setUpTableViewConstraints()
  }
  func setUpSearchBarConstraints(){
    addSubview(productSearchBar)
    productSearchBar.translatesAutoresizingMaskIntoConstraints = false
    productSearchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    productSearchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    productSearchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
  }
  func setUpTableViewConstraints(){
    addSubview(productsTableView)
    productsTableView.translatesAutoresizingMaskIntoConstraints = false
    productsTableView.topAnchor.constraint(equalTo: productSearchBar.bottomAnchor).isActive = true
    productsTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    productsTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    productsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    
  }
}
