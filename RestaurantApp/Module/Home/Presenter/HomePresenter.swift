//
//  HomePresenter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func getRestaurants() {
        loadingState = true
        homeUseCase.getRestaurants()
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self.restaurants = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: restaurant)) { content() }
    }
}
