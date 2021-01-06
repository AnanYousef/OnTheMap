//
//  UdacityLogin.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation

struct UdacityLogin: Codable {
    let udacity: UdacityLoginBody
}

struct UdacityLoginBody: Codable {
    let username: String
    let password :String
}
