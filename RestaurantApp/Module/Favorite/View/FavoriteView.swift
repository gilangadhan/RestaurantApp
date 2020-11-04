//
//  FavoriteView.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    var body: some View {
        ZStack {
            if presenter.loadingState {
                ActivityIndicator()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                      self.presenter.restaurants,
                        id: \.restaurantID
                    ) { restaurant in
                      ZStack {
                          self.presenter.linkBuilder(for: restaurant) {
                          RestaurantRaw(restaurant: restaurant)
                        }.buttonStyle(PlainButtonStyle())
                      }.padding(.vertical, 8)
                    }
                }
                if presenter.restaurants.count == 0 {
                    GeometryReader { geometry in
                        ScrollView(.vertical) {
                            VStack(alignment: .center, spacing: 18) {
                                Image("broke")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120)
                                Text("Empty Data")
                            }
                             .padding()
                             .frame(width: geometry.size.width)
                             .frame(minHeight: geometry.size.height)
                        }
                    }
                }
            }
        }.onAppear {
            self.presenter.getFavorites()
        }.navigationBarTitle(
            Text("Favorite"),
            displayMode: .automatic
        )
    }
}
