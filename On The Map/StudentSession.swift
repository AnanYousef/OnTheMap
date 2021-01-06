//
//  StudentSession.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation


struct StudentSession: Codable {
    let account: Account
    let session : Session
    
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}


struct PublicUserData: Codable {
    
    let firstName: String
    let lastName :String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}


struct StudentProfile: Codable {
    let firstName: String
    let lastName :String
    let uniqueKey: String
}

