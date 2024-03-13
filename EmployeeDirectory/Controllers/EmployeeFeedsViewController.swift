//
//  ViewController.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import UIKit

class EmployeeFeedsViewController: UIViewController {
    
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        EmployeeDirectoryServiceClient.shared.fetchFeedsIfNeeded { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print("There was an error\(error)")
            }
        }
    }
    
    private func setupCollectionView() {
     
        
    }
}

extension EmployeeFeedsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

