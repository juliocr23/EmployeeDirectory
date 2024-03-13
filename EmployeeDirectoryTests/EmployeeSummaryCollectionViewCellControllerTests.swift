//
//  EmployeeSummaryCollectionViewCellControllerTests.swift
//  EmployeeDirectoryTests
//
//  Created by Julio Rosario on 3/13/24.
//

import XCTest
import UIKit
@testable import EmployeeDirectory

class EmployeeSummaryCollectionViewCellControllerTests: XCTestCase {

    var cellController: EmployeeSummaryCollectionViewCellController!
    var cell: EmployeeSummaryCollectionViewCell!
    var employeeData: EmployeeData!

    override func setUp() {
        super.setUp()
        employeeData = EmployeeData(ID: "1", fullName: "John Doe", biography: "A great worker", photoURLSMAll: URL(string: "http://example.com/photo.jpg")!, photoURLLarge: URL(string: "http://example.com/largePhoto.jpg")!, team: "Engineering")
        cellController = EmployeeSummaryCollectionViewCellController(data: employeeData)
        cell = EmployeeSummaryCollectionViewCell.sizingCell
    }

    override func tearDown() {
        employeeData = nil
        cellController = nil
        cell = nil
        super.tearDown()
    }

    func testConfigureCell() {
        cellController.configure(cell)
        
       
        XCTAssertEqual(cell.nameLabel.text, employeeData.fullName, "Name label was not set correctly")
        XCTAssertEqual(cell.descriptionLabel.text, employeeData.biography, "Description label was not set correctly")
        XCTAssertEqual(cell.teamLabel.text, employeeData.team, "Team label was not set correctly")
        XCTAssertNotNil(cell.profileImageView.image)
    }
}

