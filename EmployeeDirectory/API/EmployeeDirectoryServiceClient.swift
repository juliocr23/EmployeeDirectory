//
//  EmployeeDirectoryServiceClient.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import Foundation

protocol ServiceClient {
    func fetchFeedsIfNeeded(completion: @escaping (Result<EmployeeDirectoryData, HttpError>) -> Void)
}
final class EmployeeDirectoryServiceClient : ServiceClient {
    var endPoint = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    static let shared = EmployeeDirectoryServiceClient()
    
    private init() {}
    
    func fetchFeedsIfNeeded(completion: @escaping (Result<EmployeeDirectoryData, HttpError>) -> Void) {
        guard let url = URL(string: endPoint) else {
            completion(.failure(.malformedURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let resultedData = data, error == nil else {
                completion(.failure(.clientError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let employeeData = try decoder.decode(EmployeeDirectoryData.self, from: resultedData)
                completion(.success(employeeData))
            }catch {
                completion(.failure(.parsingError))
            }
        }
        
        task.resume()
    }
}
