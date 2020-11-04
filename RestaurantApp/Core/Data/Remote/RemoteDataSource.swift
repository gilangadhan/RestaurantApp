//
//  RemoteDataSource.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: class {
    func getRestaurants() -> Observable<[RestaurantResponse]>
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurant>
}

final class RemoteDataSource: NSObject {
    private override init() {}
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getRestaurants() -> Observable<[RestaurantResponse]> {
        return Observable<[RestaurantResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.list.url) {
                AF.request(url).validate().responseDecodable(of: RestaurantsResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.restaurants)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
    func getDetailRestaurant(idRestaurant: String) -> Observable<DetailRestaurant> {
        return Observable<DetailRestaurant>.create { observer in
            if let url = URL(string: "\(Endpoints.Gets.detail.url)\(idRestaurant)") {
                AF.request(url).validate().responseDecodable(of: DetailRestaurantResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.restaurant)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
