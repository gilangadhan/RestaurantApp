//
//  SceneDelegate.swift
//  Restaurant App
//
//  Created by Ahmad Suyadi on 27/10/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let favoriteUseCase = Injection.init().provideFavorite()
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)

        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)

        if let windowScene = scene as? UIWindowScene {
          let window = UIWindow(windowScene: windowScene)
          window.rootViewController = UIHostingController(rootView: contentView)
          self.window = window
          window.makeKeyAndVisible()
        }
    }
}
