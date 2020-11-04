//
//  DetailRestaurantMapper.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation

class DetailRestaurantMapper {
    static func mapDetailRestaurantToDomains(
        input detailRestaurant: DetailRestaurant) -> DetailRestaurantModel {
            return DetailRestaurantModel(
                restarurandID: detailRestaurant.restaurantID ,
                name: detailRestaurant.name ,
                restaurantDescription: detailRestaurant.restaurantDescription ,
                city: detailRestaurant.city ,
                address: detailRestaurant.address ,
                pictureID: detailRestaurant.pictureID ,
                categories: detailRestaurant.categories ,
                menus: detailRestaurant.menus,
                rating: detailRestaurant.rating ,
                customerReviews: detailRestaurant.customerReviews
            )
        }
}
