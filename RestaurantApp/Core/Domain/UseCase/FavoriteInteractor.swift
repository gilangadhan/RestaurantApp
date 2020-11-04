//
//  FavoriteInteractor.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavorites () -> Observable<[RestaurantModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: RestaurantRepositoryProtocol
    required init (repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    func getFavorites() -> Observable<[RestaurantModel]> {
        repository.getFavorites()
    }
}
