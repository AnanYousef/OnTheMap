//
//  LocationState.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation

import CoreLocation

protocol LocationState {
    var address: String { get }
}

class EmptyLocationState: LocationState {
    let address: String = ""
}

class EnabledLocationState: LocationState {
    let address: String
    
    init(address: String) {
        self.address = address
    }
}

class ReadyLocationState: LocationState {
    let address: String
    let coordinates:CLLocationCoordinate2D
    
    init(address: String, coordinates:CLLocationCoordinate2D) {
        self.address = address
        self.coordinates = coordinates
    }
}
