//
//  StudentLocation.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation

struct StudentLocation: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String?
}

