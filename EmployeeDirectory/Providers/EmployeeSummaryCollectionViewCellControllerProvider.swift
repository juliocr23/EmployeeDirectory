//
//  EmployeeSummaryCollectionViewCellControllerProvider.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/12/24.
//

import Foundation

protocol CollectionViewCellControllerProvider {
    func provideCellControllers(for: EmployeeDirectoryData) -> [any CollectionViewCellController]
}
final class EmployeeSummaryCollectionViewCellControllerProvider : CollectionViewCellControllerProvider {
    
    typealias Model = EmployeeDirectoryData
    
    func provideCellControllers(for model: EmployeeDirectoryData) -> [any CollectionViewCellController] {
        return model.employees.map { employeeData in
            EmployeeSummaryCollectionViewCellController(data: employeeData)
        }
    }
}
