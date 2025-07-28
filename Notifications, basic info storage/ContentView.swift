//
//  ContentView.swift
//  Notifications, basic info storage
//
//  Created by Bartosz Strzecha on 28/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Part 1 / Task 1")) {
                    NavigationLink("Send Notification View") {
                        SendNotificationViewController().asSwiftUIView()
                    }
                    NavigationLink("Observer View") {
                        ObserverViewController().asSwiftUIView()
                    }
                }
                Section(header: Text("Part 1 / Task 2")) {
                    NavigationLink("Keyboard Handling View") {
                        KeyboardHandlingViewController().asSwiftUIView()
                    }
                }
                Section(header: Text("Part 1 / Task 3")) {
                    NavigationLink("Lifecycle Observer View") {
                        LifecycleObserverViewController().asSwiftUIView()
                    }
                }
                Section(header: Text("Part 2 / Task 1")) {
                    NavigationLink("Settings View") {
                        SettingsViewController().asSwiftUIView()
                    }
                }
                
            }
            .listStyle(.insetGrouped)
            .onAppear {
                ThemeManager.applyStoredTheme()
            }
        }
    }
}

#Preview {
    ContentView()
}

extension UIViewController {
    func asSwiftUIView() -> some View {
        AsSwiftUIView {
            self
        }
        .ignoresSafeArea()
    }
}

struct AsSwiftUIView: UIViewControllerRepresentable {
    private let make: () -> UIViewController
    
    init(make: @escaping () -> UIViewController) {
        self.make = make
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        make()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
