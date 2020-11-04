//
//  DetailView.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                ScrollView(.vertical) {
                    VStack {
                        imageDetailRestaurant
                        content
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            presenter.getRestaurantByID(idRestaurant: self.presenter.restaurant.restaurantID)
            presenter.getDetailRestaurant(idRestaurant: self.presenter.restaurant.restaurantID)
        }
        .navigationBarTitle(
            Text(self.presenter.restaurant.name),
            displayMode: .large
        )
    }
}

extension DetailView {
    var spacer: some View {
        Spacer()
    }
    var loadingIndicator: some View {
        ZStack {
            ActivityIndicator()
        }.frame(width: UIScreen.main.bounds.width - 32)
    }
    var imageDetailRestaurant: some View {
        WebImage(url: URL(string: "\(Endpoints.Gets.largeImage.url)\(self.presenter.restaurant.pictureId)"))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width - 32)
            .cornerRadius(30)
    }
    var location: some View {
        HStack {
            Image("location").resizable()
                .frame(width: 14, height: 14)
            if presenter.loadingDetailState {
                Text(self.presenter.restaurant.city)
                    .font(.system(size: 13))
            } else {
                Text("\(self.presenter.detailRestaurant.city), \(self.presenter.detailRestaurant.address)")
                    .font(.system(size: 13))
            }
        }
    }
    var description: some View {
        Text(self.presenter.restaurant.restaurantDescription)
            .font(.system(size: 15))
    }
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
            .frame(alignment: .leading)
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                location
                spacer
                Button {
                    presenter.setFavorite(restaurant: self.presenter.restaurantDB)
                } label: {
                    if self.presenter.isFavorite {
                        Image(systemName: "bookmark.fill")
                    } else {
                        Image(systemName: "bookmark")
                    }
                }
            }.padding(.top)
            headerTitle("Description")
                .padding([.top, .bottom])
            description
            if presenter.loadingDetailState {
                loadingIndicator.padding(.top)
            } else {
                headerTitle("Foods")
                    .padding([.top, .bottom])
                listFood
                headerTitle("Drinks")
                    .padding([.top, .bottom])
                listDrink
                headerReview
                listReview
            }
        }
    }
    var listFood: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(
                    self.presenter.detailRestaurant.menus.foods,
                    id: \.name
                ) { food in
                    ItemCardRaw(name: food.name, image: "fast-food")
                }
            }
        }
    }
    var listDrink: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(
                    self.presenter.detailRestaurant.menus.drinks,
                    id: \.name
                ) { drink in
                    ItemCardRaw(name: drink.name, image: "juice")
                }
            }
        }
    }
    var headerReview: some View {
        HStack {
            Image("star").resizable()
                .frame(width: 20, height: 20)
            Text("""
                \(self.presenter.detailRestaurant.rating.formateRate)  (\(self.presenter.detailRestaurant.customerReviews.count) reviews)
                """
            )
            .font(.system(size: 15))
        }.padding([.top, .bottom])
    }
    var listReview: some View {
        ScrollView(.vertical) {
            ForEach(
                self.presenter.detailRestaurant.customerReviews,
                id: \.name
            ) { review in
                ItemReviewRaw(customerReview: review, image: "user")
            }
        }
    }
}
