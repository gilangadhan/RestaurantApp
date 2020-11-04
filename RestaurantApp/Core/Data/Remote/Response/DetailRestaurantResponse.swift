//
//  DetailRestaurantResponse.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation

// MARK: - DetailRestaurantResponse
struct DetailRestaurantResponse: Codable {
    let error: Bool
    let message: String
    let restaurant: DetailRestaurant
}

// MARK: - Restaurant
struct DetailRestaurant: Codable {
    let restaurantID, name, restaurantDescription, city: String
    let address, pictureID: String
    let categories: [Category]
    let menus: Menus
    let rating: Double
    let customerReviews: [CustomerReview]

    enum CodingKeys: String, CodingKey {
        case restaurantID = "id"
        case name
        case restaurantDescription = "description"
        case city, address
        case pictureID = "pictureId"
        case categories, menus, rating, customerReviews
    }
}

// MARK: - Category
struct Category: Codable {
    let name: String
}

// MARK: - ConsumerReview
struct CustomerReview: Codable {
    let name, review, date: String
}

// MARK: - Menus
struct Menus: Codable {
    let foods, drinks: [Category]
}
