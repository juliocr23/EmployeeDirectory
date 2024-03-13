//
//  EmployeeDirectoryServiceClientTests.swift
//  EmployeeDirectoryTests
//
//  Created by Julio Rosario on 3/13/24.
//

import XCTest
@testable import EmployeeDirectory
@testable import OHHTTPStubs
@testable import OHHTTPStubsSwift

class EmployeeDirectoryServiceClientTests: XCTestCase {
    
    var client: EmployeeDirectoryServiceClient!
    
    override func setUp() {
        super.setUp()
        client = EmployeeDirectoryServiceClient.shared
        OHHTTPStubs.HTTPStubs.setEnabled(true)
    }
    
    override func tearDown() {
        client = nil
        OHHTTPStubs.HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testFetchFeedsIfNeededWithMalformedURL() {
        client.endPoint = "This is not a URL"
        let expectation = self.expectation(description: "Completion handler invoked")
        
        client.fetchFeedsIfNeeded { result in
            if case .failure(let error) = result, case .malformedURL = error {
                expectation.fulfill()
            } else {
                XCTFail("Expected malformedURL error")
            }
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchFeedsIfNeededWithClientError() {
        stub(condition: isHost("s3.amazonaws.com")) { _ in
            return HTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue))
        }

        let expectation = self.expectation(description: "Completion handler invoked")

        client.fetchFeedsIfNeeded { result in
            if case .failure(let error) = result, case .clientError = error {
                expectation.fulfill()
            } else {
                XCTFail("Expected clientError")
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }


    func testFetchFeedsIfNeededSuccess() {
        stub(condition: isHost("s3.amazonaws.com")) { _ in
            let stubPath = OHPathForFile("SuccessResponse.json", type(of: self))!
            return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
        }

        let expectation = self.expectation(description: "Completion handler invoked")

        client.fetchFeedsIfNeeded { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure:
                XCTFail("Expected success, but got a failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
