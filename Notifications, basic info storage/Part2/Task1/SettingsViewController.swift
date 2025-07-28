//
//  SettingsViewController.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Light", "Dark"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        setupLayout()
        loadStoredTheme()
        segmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
    }
    
    private func setupLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func loadStoredTheme() {
        let stored = UserDefaults.standard.string(forKey: themePreferenceKey)
        let theme = Theme(rawValue: stored ?? "") ?? .light
        
        ThemeManager.applyTheme(theme)
        
        segmentedControl.selectedSegmentIndex = (theme == .light) ? 0 : 1
    }
    
    @objc private func themeChanged(_ sender: UISegmentedControl) {
        let selectedTheme: Theme = sender.selectedSegmentIndex == 0 ? .light : .dark
        ThemeManager.applyTheme(selectedTheme)
    }
}

#Preview {
    SettingsViewController()
}
