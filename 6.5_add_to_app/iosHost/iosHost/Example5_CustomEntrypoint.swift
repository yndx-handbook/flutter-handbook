//
//  Example5_CustomEntrypoint.swift
//  iosHost
//
//  Пример 5: Кастомная точка входа (строки 647-659)
//

import SwiftUI
import Flutter

struct Example5_CustomEntrypoint: View {
    @State private var showFlutter = false
    @State private var customEngine: FlutterEngine?
    @State private var entrypoint: String = "main"
    @State private var arguments: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Кастомная точка входа")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Запуск Flutter с пользовательской функцией")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Точка входа:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                TextField("Имя функции", text: $entrypoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(.body, design: .monospaced))
                    .disabled(customEngine != nil)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Аргументы (через запятую):")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                TextField("arg1, arg2, arg3", text: $arguments)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.system(.body, design: .monospaced))
                    .disabled(customEngine != nil)
                
                Text("Пример: user_123, dark_theme, en")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                Button(customEngine != nil ? "Открыть Flutter" : "Запустить с кастомной точкой входа") {
                    launchWithCustomEntrypoint()
                }
                .buttonStyle(ExampleButtonStyle(color: customEngine != nil ? .blue : .red))
                
                if customEngine != nil {
                    Button("Остановить движок") {
                        customEngine = nil
                    }
                    .buttonStyle(ExampleButtonStyle(color: .orange))
                }
            }
            .padding(.horizontal)
            
            Text(customEngine != nil ? "✅ Движок запущен" : "⚪️ Движок остановлен")
                .font(.caption)
                .foregroundColor(customEngine != nil ? .green : .gray)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 5")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFlutter) {
            if let engine = customEngine {
                SafeFlutterView(engine: engine)
            }
        }
    }
    
    private func launchWithCustomEntrypoint() {
        // Проверяем, существует ли уже движок
        if customEngine != nil {
            // Движок уже создан, просто показываем Flutter-экран
            showFlutter = true
            return
        }
        
        // Создаем новый движок
        customEngine = FlutterEngine(name: "custom_entrypoint_engine")
        
        let entrypointToUse = entrypoint.isEmpty ? nil : entrypoint
        
        // Парсим аргументы
        let args: [String]? = arguments.isEmpty ? nil : arguments
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        customEngine?.run(
            withEntrypoint: entrypointToUse,
            libraryURI: nil,
            initialRoute: nil,
            entrypointArgs: args
        )
        
        // Небольшая задержка для инициализации движка
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showFlutter = true
        }
    }
}

#Preview {
    NavigationView {
        Example5_CustomEntrypoint()
    }
}
