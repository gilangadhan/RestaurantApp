//
//  LocalDataSource.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 28/10/20.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: class {
    func getRestaurants() -> Observable<[RestaurantEntity]>
    func getRestaurantById(restaurantID: String) -> Observable<RestaurantEntity>
    func addRestaurant (from restaurants: [RestaurantEntity]) -> Observable<Bool>
    func getFavorites() -> Observable<[RestaurantEntity]>
    func setFavorite(from restaurant: RestaurantEntity) -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) ->
        LocaleDataSource = { realmDatabase in return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getRestaurantById(restaurantID: String) -> Observable<RestaurantEntity> {
        return Observable<RestaurantEntity>.create { observer in
            if let realm = self.realm {
                if let restaurantDb = realm.objects(RestaurantEntity.self)
                    .filter("restaurantID = %@", restaurantID).first {
                    observer.onNext(restaurantDb)
                    observer.onCompleted()
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    func getFavorites() -> Observable<[RestaurantEntity]> {
        return Observable<[RestaurantEntity]>.create { observer in
            if let realm = self.realm {
                let restaurants: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .filter("isFavorite == true")
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                observer.onNext(restaurants.toArray(ofType: RestaurantEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    func getRestaurants() -> Observable<[RestaurantEntity]> {
        return Observable<[RestaurantEntity]>.create { observer in
            if let realm = self.realm {
              let restaurants: Results<RestaurantEntity> = {
                realm.objects(RestaurantEntity.self)
                  .sorted(byKeyPath: "name", ascending: true)
              }()
                observer.onNext(restaurants.toArray(ofType: RestaurantEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    func addRestaurant(from restaurants: [RestaurantEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                  do {
                    try realm.write {
                      for restaurant in restaurants {
                        realm.add(restaurant, update: .all)
                      }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                  } catch {
                    observer.onError(DatabaseError.requestFailed)
                  }
                } else {
                    observer.onError(DatabaseError.invalidInstance)
                }
            return Disposables.create()
        }
    }
    func setFavorite(from restaurant: RestaurantEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    let restaurantDb = realm.objects(RestaurantEntity.self)
                        .filter("restaurantID = %@", restaurant.restaurantID).first
                    try realm.write {
                        let result = !(restaurantDb?.isFavorite ?? false)
                        restaurantDb?.isFavorite = result
                        observer.onNext(result)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
