//
//  iosHostApp.swift
//  iosHost
//
//  Created by Anton Prokofev on 13.04.2025.
//

import SwiftUI

@main
struct iosHostApp: App {
    
    // Сообщаем SwiftUI использовать AppDelegate как делегат приложения
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Передаем appDelegate в окружение для доступа из дочерних представлений
                .environmentObject(appDelegate)
        }
    }
}
