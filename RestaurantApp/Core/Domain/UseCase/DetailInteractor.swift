//
//  DetailInteractor.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getRestaurantModel() -> RestaurantModel
    func getRestaurantDB(idRestaurant: String) -> Observable<RestaurantModel>
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurantModel>
    func setFavorite(restaurant: RestaurantModel) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
    private let repository: RestaurantRepositoryProtocol
    private let restaurant: RestaurantModel
    required init(
        repository: RestaurantRepositoryProtocol,
        restaurant: RestaurantModel
    ) {
        self.repository = repository
        self.restaurant = restaurant
    }
    func getRestaurantModel() -> RestaurantModel {
        return restaurant
    }
    func getRestaurantDB(idRestaurant: String) -> Observable<RestaurantModel> {
        return repository.getRestaurantByID(restaurantID: idRestaurant)
    }
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurantModel> {
        return repository.getDetailRestaurant(idRestaurant: idRestaurant)
    }
    func setFavorite(restaurant: RestaurantModel) -> Observable<Bool> {
        return repository.setFavorite(restaurant: restaurant)
    }
}
