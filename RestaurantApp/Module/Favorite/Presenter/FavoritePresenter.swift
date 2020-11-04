//
//  FavoritePresenter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI
import RxSwift

class FavoritePresenter: ObservableObject {
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    private let disposeBag = DisposeBag()
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    func getFavorites() {
        loadingState = true
        favoriteUseCase.getFavorites()
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
