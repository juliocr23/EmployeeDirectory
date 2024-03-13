//
//  CollectionViewSectionProvider.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/12/24.
//

import Foundation
final class EmployeeSummaryCollectionViewCellControllerSectionProvider {
    let dataSource: EmployeeDirectoryServiceClient
    let collectionViewCellControllerProvider: any CollectionViewCellControllerProvider
    
    init(dataSource: EmployeeDirectoryServiceClient,
         collectionViewCellControllerProvider: any CollectionViewCellControllerProvider) {
        self.dataSource = dataSource
        self.collectionViewCellControllerProvider = collectionViewCellControllerProvider
    }
    
    func provideCollectionViewSection() async throws -> CollectionViewSection {
        return try await withCheckedThrowingContinuation { continuation in
            dataSource.fetchFeedsIfNeeded { result in
                switch result {
                case .success(let data):
                    let collectionsViewCellControllers = self.collectionViewCellControllerProvider.provideCellControllers(for: data)
                    continuation.resume(returning: .init(cellControllers: collectionsViewCellControllers))
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
