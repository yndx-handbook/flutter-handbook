//
//  SharedFlutterComponents.swift
//  iosHost
//
//  Общие компоненты для безопасной работы с Flutter
//

import SwiftUI
import Flutter

// MARK: - Safe Flutter View

/// Безопасная обертка для FlutterViewController
/// Автоматически отсоединяет контроллер от движка при закрытии,
/// предотвращая ошибку "FlutterEngine is already used"
struct SafeFlutterView: UIViewControllerRepresentable {
    let engine: FlutterEngine
    
    func makeUIViewController(context: Context) -> FlutterViewController {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        return flutterViewController
    }
    
    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}
    
    static func dismantleUIViewController(_ uiViewController: FlutterViewController, coordinator: ()) {
        // Важно: отсоединяем контроллер от движка при закрытии
        // Это позволяет переиспользовать один движок для нескольких экранов
        uiViewController.engine.viewController = nil
    }
}

// MARK: - Example Button Style

/// Общий стиль кнопок для всех примеров
struct ExampleButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}

