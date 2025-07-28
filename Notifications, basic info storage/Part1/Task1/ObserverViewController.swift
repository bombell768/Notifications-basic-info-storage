//
//  ObserverViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import UIKit

class ObserverViewController: UIViewController {
    
    lazy private var notificationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Waiting for notification..."
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationLabel)
        
        NSLayoutConstraint.activate([
            notificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification),
            name: Notification.Name("Button tapped notification"),
            object: nil
        )
    }
    
    @objc private func handleNotification(notification: Notification) {
        notificationLabel.text = Notification.Name("Button tapped notification").rawValue + " received!"
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Button tapped notification"), object: nil)
    }
    
}

#Preview {
    ObserverViewController()
}
