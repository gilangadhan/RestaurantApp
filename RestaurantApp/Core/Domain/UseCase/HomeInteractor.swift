//
//  HomeInteractor.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getRestaurants() -> Observable<[RestaurantModel]>
}

class HomeInteractor: HomeUseCase {
    func getRestaurants() -> Observable<[RestaurantModel]> {
        return repository.getRestauranst()
    }
    private let repository: RestaurantRepositoryProtocol
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
}
