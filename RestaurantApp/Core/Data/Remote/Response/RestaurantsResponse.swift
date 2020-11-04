//
//  RestaurantsResponse.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation

struct RestaurantsResponse: Decodable {
    let restaurants: [RestaurantResponse]
}

struct RestaurantResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case restaurantID = "id"
        case name
        case restaurantDescription = "description"
        case pictureId
        case city
        case rating
    }
    let restaurantID: String?
    let name: String?
    let restaurantDescription: String?
    let pictureId: String?
    let city: String?
    let rating: Double?
}
