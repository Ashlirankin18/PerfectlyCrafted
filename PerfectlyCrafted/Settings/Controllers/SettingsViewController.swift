//
//  SettingsViewController.swift
//  PerfectlyCrafted
//
//  Created by Ashli Rankin on 3/22/20.
//  Copyright © 2020 Ashli Rankin. All rights reserved.
//

import UIKit

/// `UIViewController` subclass which displays the various app settings.
final class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var colorSelectionCollectionView: UICollectionView!
    
    private let allColors = AssetsColor.allCases
    private var selectedColor: UIColor?
    private var selectedIndexPath: IndexPath?
    
    private lazy var saveBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped(sender:)))
    
    private lazy var cancelBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonTapped(sender:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        configureCollectionView()
        configureBarButtonItems()
    }
    
    private func configureCollectionView() {
        colorSelectionCollectionView.register(UINib(nibName: "ColorSelectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCell")
        colorSelectionCollectionView.dataSource = self
        colorSelectionCollectionView.delegate = self
    }
    
    private func configureBarButtonItems() {
        navigationItem.rightBarButtonItem = saveBarButtonItem
        navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    @objc private func saveButtonTapped(sender: UIBarButtonItem) {
        if let index = selectedIndexPath?.row, let selectedTheme = AssetsColor(rawValue: index) {
            selectedTheme.apply()
        }
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped(sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension SettingsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorSelectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        let color = allColors[indexPath.row].color
        var isSelected: Bool
        if AssetsColor.current.color == color {
            selectedColor = color
            selectedIndexPath = indexPath
            isSelected = true
        } else {
            isSelected = false
        }
        cell.viewModel = ColorSelectionCollectionViewCell.ViewModel(color: color, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorSelectionCollectionViewCell  else {
            return
        }
        let color = allColors[indexPath.row].color
        if let selectedIndexPath = selectedIndexPath, let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? ColorSelectionCollectionViewCell {
            selectedCell.viewModel?.isSelected = false
        }
        
        cell.viewModel?.isSelected = true
        selectedIndexPath = indexPath
        selectedColor = color
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorSelectionCollectionViewCell  else {
            return
        }
        cell.viewModel?.isSelected = false
    }
}
