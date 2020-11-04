//
//  DetailRestaurantModel.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation

// MARK: - Restaurant
struct DetailRestaurantModel {
    let restarurandID, name, restaurantDescription, city: String
    let address, pictureID: String
    let categories: [Category]
    let menus: Menus
    let rating: Double
    let customerReviews: [CustomerReview]
    public static var defaultValue: DetailRestaurantModel {
        return DetailRestaurantModel(
            restarurandID: "",
            name: "",
            restaurantDescription: "",
            city: "",
            address: "",
            pictureID: "",
            categories: [],
            menus: Menus(
                foods: [],
                drinks: []
            ),
            rating: 0.0,
            customerReviews: []
        )
    }
}
