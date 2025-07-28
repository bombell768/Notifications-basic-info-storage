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
                Section(header: Text("Task 1")) {
                    NavigationLink("Send Notification View") {
                        SendNotificationViewController().asSwiftUIView()
                    }
                    NavigationLink("Observer View") {
                        ObserverViewController().asSwiftUIView()
                    }
                }
                Section(header: Text("Task 2")) {
                    NavigationLink("Send Notification View") {
                        SendNotificationViewController().asSwiftUIView()
                    }
                    NavigationLink("Observer View") {
                        ObserverViewController().asSwiftUIView()
                    }
                }
                
            }
            .listStyle(.insetGrouped)
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
