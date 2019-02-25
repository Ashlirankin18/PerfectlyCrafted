//
//  SearchProductViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/20/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit

class SearchProductViewController: UIViewController {
  
  var allHairProducts = [AllHairProducts](){
    didSet{
      DispatchQueue.main.async {
        self.searchView.productsTableView.reloadData()
      }
    }
  }
  
  init(allHairProducts:[AllHairProducts]){
    super.init(nibName: nil, bundle: nil)
    self.allHairProducts = allHairProducts.sorted{$0.results.name < $1.results.name}
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  let searchView = SearchView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(searchView)
    setNavigationItems()
    searchView.productsTableView.dataSource = self
    searchView.productsTableView.delegate = self
    searchView.productSearchBar.delegate = self
  }
  
  func setNavigationItems(){
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonPressed))
    self.navigationItem.title = "\(allHairProducts.count) Products"
  }
  
  @objc private func backButtonPressed(){
    self.dismiss(animated: true, completion: nil)
  }
  private func setImage(imageView:UIImageView,urlString:String){
    if let image = ImageCache.shared.fetchImageFromCache(urlString: urlString){
      imageView.image = image
    } else {
      ImageCache.shared.fetchImageFromNetwork(urlString: urlString) { (error, image) in
        if let error = error{
          print(error.errorMessage())
        }
        if let image = image{
          DispatchQueue.main.async {
            imageView.image = image
          }
        }
      }
    }
  }
  func getAllHairProducts(){
    HairProductApiClient.getHairProducts { (error, allHairProducts) in
      if let error = error{
        print(error)
      }
      if allHairProducts != nil{
        self.allHairProducts = allHairProducts!.sorted{$0.results.name < $1.results.name}
      }
    }
  }
}
extension SearchProductViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allHairProducts.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = searchView.productsTableView.dequeueReusableCell(withIdentifier: "DisplayCell", for: indexPath) as? ProductDisplayCell else {fatalError("no product displaycell found")}
    let hairProduct = allHairProducts[indexPath.row]
    let urlString = hairProduct.results.images.first?.absoluteString ?? "no string found"
    cell.productName.text = hairProduct.results.name.capitalized
    cell.categoryLabel.text = hairProduct.results.category
    setImage(imageView: cell.productImage, urlString: urlString)
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let productController = ShowProductViewController.init(hairProduct: allHairProducts[indexPath.row], view: HairProductView())
    self.navigationController?.pushViewController(productController, animated: true)
    
    
  }
}
extension SearchProductViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat.init(100)
  }
}
extension SearchProductViewController:UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let searchText = searchBar.text else {
      print("no text found")
      return
    }
    
    if searchText.isEmpty {
      getAllHairProducts()
    } else {
      let anArray = allHairProducts.filter({$0.results.name.contains(searchText.capitalized)})
      allHairProducts = anArray
   
    }
  }
}

