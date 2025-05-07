//
//  RestaurantRepository.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 03/05/25.
//

import Foundation


protocol RestaurantRepository {
    
    func getRestaurantDetails(id : String) async throws -> Restaurant
}
