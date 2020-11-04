//
//  FoodRaw.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI

struct ItemCardRaw: View {
    var name: String
    var image: String
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            imageView
            nameView
        }.frame(
            width: 120,
            height: 150,
            alignment: .center)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
    }
}

extension ItemCardRaw {
    var nameView: some View {
        Text(name).padding(.horizontal)
    }
    var imageView: some View {
        Image(image).resizable()
            .frame(width: 50, height: 50)
    }
}

struct ItemCardRaw_Previews: PreviewProvider {
    static var previews: some View {
        let name = "Ayam Bakar kjskdjf"
        let image = "fast-food"
        ItemCardRaw(name: name, image: image)
    }
}
