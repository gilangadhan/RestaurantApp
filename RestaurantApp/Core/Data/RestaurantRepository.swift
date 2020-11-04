//
//  RestaurantRepository.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation
import RxSwift

protocol RestaurantRepositoryProtocol {
    func getRestauranst() -> Observable<[RestaurantModel]>
    func getRestaurantByID(restaurantID: String) -> Observable<RestaurantModel>
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurantModel>
    func getFavorites() -> Observable<[RestaurantModel]>
    func setFavorite(restaurant: RestaurantModel) -> Observable<Bool>
}

final class RestaurantRepository: NSObject {
    typealias RestaurantInstance = (LocaleDataSource, RemoteDataSource) -> RestaurantRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    static let sharedInstance: RestaurantInstance = { localeRepo, remoteRepo in
        return RestaurantRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension RestaurantRepository: RestaurantRepositoryProtocol {
    func getRestaurantByID(restaurantID: String) -> Observable<RestaurantModel> {
        return self.locale.getRestaurantById(restaurantID: restaurantID)
            .map { RestaurantMapper.mapRestaurantEntityToModel(input: $0) }
    }
    func setFavorite(restaurant: RestaurantModel) -> Observable<Bool> {
        return self.locale.setFavorite(from: RestaurantMapper.mapRestaurantModelToEntity(
                input: restaurant))
    }
    func getFavorites() -> Observable<[RestaurantModel]> {
        return self.locale.getFavorites()
            .map { RestaurantMapper.mapRestaurantEntitiesToDomains(input: $0) }
    }
    func getRestauranst() -> Observable<[RestaurantModel]> {
        return self.locale.getRestaurants()
            .map { RestaurantMapper.mapRestaurantEntitiesToDomains(input: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getRestaurants()
                        .map { RestaurantMapper.mapRestaurantResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addRestaurant(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getRestaurants()
                            .map { RestaurantMapper.mapRestaurantEntitiesToDomains(input: $0) }
            }
        )
    }
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurantModel> {
        return self.remote.getDetailRestaurant(idRestaurant: idRestaurant)
            .map { DetailRestaurantMapper.mapDetailRestaurantToDomains(input: $0) }
    }
}
