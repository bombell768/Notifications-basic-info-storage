//
//  LifecycleObserverViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import UIKit

class LifecycleObserverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerForAppLifecycleNotifications()
    }

    private func registerForAppLifecycleNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc private func appDidEnterBackground() {
        print("App entered background")
    }

    @objc private func appWillEnterForeground() {
        print("App will enter foreground")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("LifecycleObserverViewController deinitialized – observers removed")
    }
}

#Preview {
    LifecycleObserverViewController()
}
