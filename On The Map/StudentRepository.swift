//
//  StudentRepository.swift
//  On The Map
//
//  Created by Anan Yousef on 05/01/2021.
//

import Foundation

class StudentRepository {
    
    var studentLocationList: [StudentLocation] = []
    
    var studentProfile: StudentProfile?
    
    static let sharedInstance = StudentRepository()
    
    private init() {  }
    
    func clear() {
        studentLocationList = []
        studentProfile = nil
    }

}
