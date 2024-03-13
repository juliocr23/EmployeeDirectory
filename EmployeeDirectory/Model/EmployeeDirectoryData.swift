//
//  EmployeeDirectoryData.swift
//  EmployeeDirectory
//
//  Created by Julio Rosario on 3/10/24.
//

import Foundation

struct EmployeeDirectoryData: Equatable, Decodable {
    let employees: [EmployeeData]
}

struct EmployeeData: Equatable, Decodable {
    let ID: String
    let fullName: String
    let biography: String
    let photoURLSMAll: URL
    let photoURLLarge: URL
    let team:String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        ID = try container.decode(String.self, forKey: .ID)
        fullName = try container.decode(String.self, forKey: .fullName)
        biography = try container.decode(String.self, forKey: .biography)
        photoURLSMAll = try container.decode(URL.self, forKey: .photoURLSMALL)
        photoURLLarge = try container.decode(URL.self, forKey: .photoURLLarge)
        team = try container.decode(String.self, forKey: .team)
    }
    
    init(ID: String, fullName: String,
         biography: String, photoURLSMAll: URL,
         photoURLLarge: URL, team:String) {
        self.ID = ID
        self.fullName = fullName
        self.biography = biography
        self.photoURLSMAll = photoURLSMAll
        self.photoURLLarge = photoURLLarge
        self.team = team
    }
    
    private enum CodingKeys: String, CodingKey {
        case ID = "uuid"
        case fullName = "full_name"
        case biography = "biography"
        case photoURLSMALL = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team = "team"
    }
}
