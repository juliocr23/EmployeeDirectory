//
//  CollectionViewSection.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/12/24.
//

import Foundation
import UIKit

struct CollectionViewSection {
    var cellControllers: [any CollectionViewCellController]
    init(cellControllers: [any CollectionViewCellController]) {
        self.cellControllers = cellControllers
    }
}
