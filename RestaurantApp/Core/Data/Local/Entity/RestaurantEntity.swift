//
//  RestaurantEntity.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation
import RealmSwift

class RestaurantEntity: Object {
    @objc dynamic var restaurantID: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionRestaurant: String = ""
    @objc dynamic var pictureId: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var isFavorite: Bool = false
    override static func primaryKey() -> String? {
        return "restaurantID"
      }
}
