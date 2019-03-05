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
        self.navigationItem.title = "\(self.allHairProducts.count) Products"
        self.searchView.productsTableView.reloadData()
      }
    }
  }
  
  let searchView = SearchView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(searchView)
    searchView.productsTableView.dataSource = self
    searchView.productsTableView.delegate = self
    searchView.productSearchBar.delegate = self
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.allHairProducts = ProductDataManager.getProducts().sorted{$0.results.name < $1.results.name}
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
    let navigationController = UINavigationController(rootViewController: productController)
    
    self.present(navigationController, animated: true, completion: nil)
    
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
      allHairProducts = ProductDataManager.getProducts()
    } else {
      let anArray = allHairProducts.filter({$0.results.name.contains(searchText.capitalized)})
      allHairProducts = anArray.sorted{$0.results.name < $1.results.name}
    self.navigationItem.title = "\(allHairProducts.count) Products"
    }
  }
}



