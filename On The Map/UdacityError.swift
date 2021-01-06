//
//  UdacityError.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation

class UdacityError: Codable, Error {
    let status: Int
    let error: String
}

