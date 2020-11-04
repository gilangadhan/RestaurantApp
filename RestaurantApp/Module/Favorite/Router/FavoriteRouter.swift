//
//  FavoriteRouter.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
