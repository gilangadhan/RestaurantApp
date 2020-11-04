//
//  HomeView.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//
import SwiftUI
import Foundation

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
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
            }
        }.onAppear {
            if self.presenter.restaurants.count == 0 {
                self.presenter.getRestaurants()
            }
        }.navigationBarTitle(
            Text("Restaurant App"),
            displayMode: .automatic
        )
    }
}
