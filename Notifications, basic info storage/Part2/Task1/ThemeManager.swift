//
//  ThemeManager.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import SwiftUI

enum Theme: String {
    case light
    case dark
    
    var interfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}

let themePreferenceKey = "selectedTheme"

struct ThemeManager {
    static func applyStoredTheme() {
        let stored = UserDefaults.standard.string(forKey: themePreferenceKey)
        let theme = Theme(rawValue: stored ?? "") ?? .light
        applyTheme(theme)
    }

    static func applyTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: themePreferenceKey)
        
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .forEach { $0.overrideUserInterfaceStyle = theme.interfaceStyle }
    }
}
