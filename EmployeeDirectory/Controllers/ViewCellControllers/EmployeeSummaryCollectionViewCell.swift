//
//  EmployeeSummaryCollectionViewCell.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import UIKit

protocol NibBacking {
    static var nib: UINib { get }
    static var reuseableIdentifier: String { get }
}

extension NibBacking where Self : UICollectionViewCell {
    static func instantiateFromNib() -> Self {
        return nib.instantiate(withOwner: nil, options: nil).first! as! Self
    }
}

final class EmployeeSummaryCollectionViewCell: UICollectionViewCell, NibBacking {
    static let reuseableIdentifier = String(describing: EmployeeSummaryCollectionViewCell.self)
    static let nib: UINib = UINib(nibName: reuseableIdentifier, bundle: nil)
    static let sizingCell = instantiateFromNib()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    private func resetToInitialState() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
