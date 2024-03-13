//
//  EmployeeSummaryCollectionViewCellController.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import Foundation
import UIKit
import SDWebImage


protocol CollectionViewCellController<Cell> : AnyObject {
    associatedtype Cell: UICollectionViewCell
    
    func configure(_ cell: Cell)
}

final class EmployeeSummaryCollectionViewCellController : CollectionViewCellController {
    
    typealias Cell = EmployeeSummaryCollectionViewCell
    let data: EmployeeData
    
    init(data: EmployeeData) {
        self.data = data
    }
    
    func configure(_ cell: Cell) {
        cell.nameLabel.text = data.fullName
        cell.descriptionLabel.text = data.biography
        cell.teamLabel.text = data.team
        cell.profileImageView.sd_setImage(with: data.photoURLSMAll, placeholderImage: .defaultPlaceHolderImage)
    }
}

extension UIImage {
    static var defaultPlaceHolderImage: UIImage {
        UIImage(named: "profileImagePlaceHolder") ?? UIImage()
    }
}
