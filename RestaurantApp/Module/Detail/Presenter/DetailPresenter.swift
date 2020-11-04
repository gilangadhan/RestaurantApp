//
//  DetailPresenter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import SwiftUI
import RxSwift

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    @Published var restaurant: RestaurantModel
    @Published var restaurantDB: RestaurantModel = RestaurantModel.defaultValue
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var detailRestaurant: DetailRestaurantModel = DetailRestaurantModel.defaultValue
    @Published var loadingDetailState: Bool = false
    @Published var isFavorite: Bool = false
    private let disposeBag = DisposeBag()
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        self.restaurant = detailUseCase.getRestaurantModel()
    }
    func getRestaurantByID(idRestaurant: String) {
        loadingState = true
        detailUseCase.getRestaurantDB(idRestaurant: idRestaurant)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self.loadingState = false
                self.restaurantDB = result
                self.isFavorite = result.isFavorite
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    func getDetailRestaurant(idRestaurant: String) {
        loadingDetailState = true
        detailUseCase.getDetailRestaurant(idRestaurant: idRestaurant)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self.loadingDetailState = false
                self.detailRestaurant = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingDetailState = false
            }.disposed(by: disposeBag)
    }
    func setFavorite(restaurant: RestaurantModel) {
        detailUseCase.setFavorite(restaurant: restaurant)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self.isFavorite = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
