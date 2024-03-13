//
//  EmployeeDataTests.swift
//  EmployeeDirectoryTests
//
//  Created by Julio Rosario on 3/13/24.
//

import XCTest
@testable import EmployeeDirectory

class EmployeeDataTests: XCTestCase {

    func testEmployeeDataDecoding() {
        // Define a JSON string that represents a valid employee
        let jsonString = """
        {
            "uuid": "12345",
            "full_name": "John Doe",
            "biography": "A hardworking employee",
            "photo_url_small": "https://example.com/photo_small.jpg",
            "photo_url_large": "https://example.com/photo_large.jpg",
            "team": "Engineering"
        }
        """

        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert string to Data")
            return
        }

        do {
            let employee = try JSONDecoder().decode(EmployeeData.self, from: jsonData)

            XCTAssertEqual(employee.ID, "12345")
            XCTAssertEqual(employee.fullName, "John Doe")
            XCTAssertEqual(employee.biography, "A hardworking employee")
            XCTAssertEqual(employee.photoURLSMAll.absoluteString, "https://example.com/photo_small.jpg")
            XCTAssertEqual(employee.photoURLLarge.absoluteString, "https://example.com/photo_large.jpg")
            XCTAssertEqual(employee.team, "Engineering")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }

    func testEmployeeDirectoryDataDecoding() {
        // Define a JSON string that represents a directory with one employee
        let jsonString = """
        {
            "employees": [
                {
                    "uuid": "12345",
                    "full_name": "John Doe",
                    "biography": "A hardworking employee",
                    "photo_url_small": "https://example.com/photo_small.jpg",
                    "photo_url_large": "https://example.com/photo_large.jpg",
                    "team": "Engineering"
                }
            ]
        }
        """

        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert string to Data")
            return
        }

        do {
            let directory = try JSONDecoder().decode(EmployeeDirectoryData.self, from: jsonData)

            XCTAssertEqual(directory.employees.count, 1)

            let employee = directory.employees.first!
            XCTAssertEqual(employee.ID, "12345")
            XCTAssertEqual(employee.fullName, "John Doe")
            XCTAssertEqual(employee.biography, "A hardworking employee")
            XCTAssertEqual(employee.photoURLSMAll.absoluteString, "https://example.com/photo_small.jpg")
            XCTAssertEqual(employee.photoURLLarge.absoluteString, "https://example.com/photo_large.jpg")
            XCTAssertEqual(employee.team, "Engineering")
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
