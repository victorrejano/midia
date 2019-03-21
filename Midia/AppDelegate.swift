//
//  AppDelegate.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/25/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Main screens
    var homeViewController: HomeViewController!
    var searchViewController: SearchViewController!
    
    var currentMediaItemKind: MediaItemKind! {
        didSet {
            let provider = MediaItemProvider(withMediaItemKind: currentMediaItemKind)
            homeViewController.mediaItemProvider = provider
            searchViewController.mediaItemProvider = provider
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
            let homeController = tabBarController.viewControllers?.first as? HomeViewController,
            let searchController = tabBarController.viewControllers?[1] as? SearchViewController else {
            fatalError("Wrong initial setup")
        }
        
        homeViewController = homeController
        searchViewController = searchController
        
        currentMediaItemKind = .book

        subscribeToMediaItemKindChanged()
        return true
    }

}


extension AppDelegate {
    
    private func subscribeToMediaItemKindChanged() {
        
        let notificationType = NotificationsType.mediaItemKindChanged
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationType.name), object: nil, queue: nil, using: changeMediaItemProvider(_:))
    }
    
    private func changeMediaItemProvider(_ notification: Notification) {
        let notificationType = NotificationsType.mediaItemKindChanged
        
        guard let newMediaItemKind = notification.userInfo?[notificationType.key] as? MediaItemKind else { return }
        
        currentMediaItemKind = newMediaItemKind
        
    }
}
