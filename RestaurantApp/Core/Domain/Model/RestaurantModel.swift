//
//  RestaurantModel.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation

struct RestaurantModel {
    let restaurantID: String
    let name: String
    let restaurantDescription: String
    let pictureId: String
    let city: String
    let rating: Double
    let isFavorite: Bool
    public static var defaultValue: RestaurantModel {
        return RestaurantModel(
            restaurantID: "",
            name: "",
            restaurantDescription: "",
            pictureId: "",
            city: "",
            rating: 0.0,
            isFavorite: false
        )
    }
}
