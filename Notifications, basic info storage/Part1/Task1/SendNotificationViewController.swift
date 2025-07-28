//
//  Task1ViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import UIKit

class SendNotificationViewController: UIViewController {
    
    lazy private var sendNotificationButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Send notification"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(sendNotification), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        sendNotificationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendNotificationButton)
        NSLayoutConstraint.activate([
            sendNotificationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendNotificationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func sendNotification() {
        NotificationCenter.default.post(name: Notification.Name("Button tapped notification"), object: nil)
    }

}

#Preview {
    SendNotificationViewController()
}
