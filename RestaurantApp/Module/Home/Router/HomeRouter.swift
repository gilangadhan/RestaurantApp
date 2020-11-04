//
//  HomeRouter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
