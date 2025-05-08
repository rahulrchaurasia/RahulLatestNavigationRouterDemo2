//
//  User.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 08/05/25.
//

import Foundation


struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let mobile: String
    let email: String
    let gender: String
    let dob: String
    let occupation: String
    
    let createdAt: String
    
    
}
