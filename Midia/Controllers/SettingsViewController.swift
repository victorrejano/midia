//
//  SettingsViewController.swift
//  Midia
//
//  Created by Victor on 21/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didChangeMediaItemKind(_ sender: UISegmentedControl) {
        
        // get selected value
        let mediaItemKindSelected: MediaItemKind = sender.selectedSegmentIndex == 0 ? .book : .movie
        
        // Info to subscribers
        notifyMediaItemKindChange(to: mediaItemKindSelected)
    }
    
    private func notifyMediaItemKindChange(to mediaItem: MediaItemKind) {
        
        let notificationCenter = NotificationCenter.default
        
        let notificationType = NotificationsType.mediaItemKindChanged
        let notification =  Notification(name: Notification.Name(rawValue: notificationType.name), object: nil, userInfo: [notificationType.key: mediaItem])
        
        notificationCenter.post(notification)
    }
}
