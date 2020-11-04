//
//  RestaurantRaw.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantRaw: View {
    var restaurant: RestaurantModel
    var body: some View {
        HStack {
            imageRestauant
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

extension RestaurantRaw {
    var imageRestauant: some View {
        WebImage(url: URL(string: "\(Endpoints.Gets.smallImage.url)\(restaurant.pictureId)"))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: 80, height: 80)
            .cornerRadius(20)
            .padding([.top, .leading, .bottom], 10)
    }
    var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(restaurant.name)
                .bold()
            HStack {
                Image("location").resizable()
                    .frame(width: 13, height: 13)
                Text(restaurant.city)
                    .font(.system(size: 13))
            }
            HStack {
                Image("star").resizable()
                    .frame(
                        width: 13,
                        height: 13)
                Text(restaurant.rating.formateRate)
                    .font(.system(size: 13))
            }
        }
    }
}

struct RestaurantRaw_Previews: PreviewProvider {
    static var previews: some View {
        let restaurant = RestaurantModel(
            restaurantID: "1",
            name: "Ayam Bakar Wongsolo",
            restaurantDescription: "Enak",
            pictureId: "https://www.themealdb.com/images/category/beef.png",
            city: "Semarang",
            rating: 4.9,
            isFavorite: false
        )
        RestaurantRaw(restaurant: restaurant)
    }
}
