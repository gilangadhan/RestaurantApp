//
//  ItemReviewRaw.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import SwiftUI

struct ItemReviewRaw: View {
    var customerReview: CustomerReview
    var image: String
    var body: some View {
        HStack(alignment: .top) {
            imageUser
            VStack(alignment: .leading, spacing: 5) {
                name
                dateReview
                comment
            }
        }.frame(width: UIScreen.main.bounds.width - 32, alignment: .leading)
    }
}

extension ItemReviewRaw {
    var imageUser: some View {
        Image(image).resizable()
            .frame(width: 50, height: 50)
    }
    var name: some View {
        Text(customerReview.name).bold()
    }
    var dateReview: some View {
        Text(customerReview.date)
            .font(.system(size: 12))
    }
    var comment: some View {
        Text(customerReview.review)
    }
}

struct ItemReviewRaw_Previews: PreviewProvider {
    static var previews: some View {
        let review = CustomerReview(name: "Ahmad Suyadi", review: "Materinya mantab sekali  ", date: "28 Oktober 2020")
        let image = "user"
        ItemReviewRaw(customerReview: review, image: image)
    }
}
