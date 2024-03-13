//
//  CollectionViewController.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/12/24.
//

import Foundation
import UIKit

final class CollectionViewController : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var _sections: [CollectionViewSection] = []
    var sections: [CollectionViewSection] {
        get {
            _sections
        }
        set {
            _sections = newValue
            collectionView.reloadData()
        }
    }
    
    var collectionView: UICollectionView! {
        willSet {
            if collectionView != newValue {
                collectionView?.dataSource = nil
                collectionView?.delegate = nil
            }
        }
        
        didSet {
            if collectionView != oldValue {
                collectionView?.dataSource = self
                collectionView?.delegate = self
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellController = sections[indexPath.section].cellControllers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellController.reuseableIdentifier, for: indexPath)
        cellController._configure(cell)
        return cell
    }
}
