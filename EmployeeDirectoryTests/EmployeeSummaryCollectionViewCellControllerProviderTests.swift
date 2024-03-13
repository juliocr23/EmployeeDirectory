//
//  EmployeeSummaryCollectionViewCellControllerProviderTests.swift
//  EmployeeDirectoryTests
//
//  Created by Julio Rosario on 3/13/24.
//

import XCTest
@testable import EmployeeDirectory

class EmployeeSummaryCollectionViewCellControllerProviderTests: XCTestCase {
    
    func testProvideCellControllers() {
        // Create a mock employee directory data
        let employees: [EmployeeData] = [
            EmployeeData(ID: "1", fullName: "John Doe", biography: "Biography 1", photoURLSMAll: URL(string: "https://example.com/photo1_small.jpg")!, photoURLLarge: URL(string: "https://example.com/photo1_large.jpg")!, team: "Engineering"),
            EmployeeData(ID: "2", fullName: "Jane Doe", biography: "Biography 2", photoURLSMAll: URL(string: "https://example.com/photo2_small.jpg")!, photoURLLarge: URL(string: "https://example.com/photo2_large.jpg")!, team: "Design")
        ]
        let directoryData = EmployeeDirectoryData(employees: employees)
        let provider = EmployeeSummaryCollectionViewCellControllerProvider()
        let cellControllers = provider.provideCellControllers(for: directoryData)

        // Verify the count of the returned cell controllers
        XCTAssertEqual(cellControllers.count, employees.count, "The number of cell controllers should match the number of employees")

        for (index, controller) in cellControllers.enumerated() {
            guard let employeeController = controller as? EmployeeSummaryCollectionViewCellController else {
                XCTFail("Expected EmployeeSummaryCollectionViewCellController type")
                return
            }
            XCTAssertEqual(employeeController.data, employees[index], "The data should match the employee data provided")
        }
    }
}

