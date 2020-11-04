//
//  APICall.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation

struct API {

    static let baseUrl = "https://restaurant-api.dicoding.dev/"
    static let baseImageUrl = "https://restaurant-api.dicoding.dev/images/"

}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case list
    case detail
    case search
    case smallImage
    case largeImage
    public var url: String {
      switch self {
      case .list: return "\(API.baseUrl)list"
      case .detail: return "\(API.baseUrl)detail/"
      case .search: return "\(API.baseUrl)search?q="
      case .smallImage: return "\(API.baseImageUrl)small/"
      case .largeImage: return "\(API.baseImageUrl)large/"
      }
    }
  }
}
