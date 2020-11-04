//
//  RestaurantMapper.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation

final class RestaurantMapper {
    static func mapRestaurantResponsesToEntities(
        input restaurantResponses: [RestaurantResponse]
    ) -> [RestaurantEntity] {
        return restaurantResponses.map { result in
            let newRestaurant = RestaurantEntity()
            newRestaurant.restaurantID = result.restaurantID ?? ""
            newRestaurant.name = result.name ?? ""
            newRestaurant.descriptionRestaurant = result.restaurantDescription ?? ""
            newRestaurant.pictureId = result.pictureId ?? ""
            newRestaurant.city = result.city ?? ""
            newRestaurant.rating = result.rating ?? 0.0
            return newRestaurant
        }
    }
    static func mapRestaurantEntitiesToDomains(
        input restaurantEntities: [RestaurantEntity]
    ) -> [RestaurantModel] {
        return restaurantEntities.map { result in
            return RestaurantModel(
                restaurantID: result.restaurantID,
                name: result.name,
                restaurantDescription: result.descriptionRestaurant,
                pictureId: result.pictureId,
                city: result.city,
                rating: result.rating,
                isFavorite: result.isFavorite
            )
        }
    }
    static func mapRestaurantModelToEntity(
        input restaurantModel: RestaurantModel
    ) -> RestaurantEntity {
        let newRestaurant = RestaurantEntity()
        newRestaurant.restaurantID = restaurantModel.restaurantID
        newRestaurant.name = restaurantModel.name
        newRestaurant.descriptionRestaurant = restaurantModel.restaurantDescription
        newRestaurant.pictureId = restaurantModel.pictureId
        newRestaurant.city = restaurantModel.city
        newRestaurant.rating = restaurantModel.rating
        newRestaurant.isFavorite = restaurantModel.isFavorite
        return newRestaurant
    }
    static func mapRestaurantEntityToModel(
        input restaurantEntity: RestaurantEntity
    ) -> RestaurantModel {
        return RestaurantModel(
            restaurantID: restaurantEntity.restaurantID,
            name: restaurantEntity.name,
            restaurantDescription: restaurantEntity.descriptionRestaurant,
            pictureId: restaurantEntity.pictureId,
            city: restaurantEntity.city,
            rating: restaurantEntity.rating,
            isFavorite: restaurantEntity.isFavorite
        )
    }
}
