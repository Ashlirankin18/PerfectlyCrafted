//
//  HairProductsTableViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 2/28/19.
//  Copyright © 2019 Ashli Rankin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HairProductsTableViewController: UITableViewController {

  @IBOutlet weak var backButton: UIBarButtonItem!
  private var userProducts = [ProductModel](){
    didSet{
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  private var userSession: UserSession!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        userSession = AppDelegate.theUser
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    getUserProducts()
    self.tableView.dataSource = self
    }

  @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func addProductPressed(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  private func getUserProducts(){
    if let user = userSession.getCurrentUser(){
      let documentReference = DataBaseManager.firebaseDB.collection(FirebaseCollectionKeys.products)
      documentReference.getDocuments { (snapshot, error) in
        if let error = error {
          print(error.localizedDescription)
        }
        else if let snapshot = snapshot {
          let qurey = snapshot.query.whereField("userId", isEqualTo: user.uid)
          qurey.getDocuments(completion: { (snapshot, error) in
            if let error = error{
              print(error.localizedDescription)
            }
            else if let snapshot = snapshot {
              let document = snapshot.documents
              document.forEach{
               let product =  ProductModel.init(dict: $0.data())
                self.userProducts.append(product)
              }
            }
          })
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  return  userProducts.count
  }
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
    let product = userProducts[indexPath.row]
    cell.textLabel?.text = product.productName
    return cell
  }
}
