//
//  ExamplesMenuView.swift
//  iosHost
//
//  Главное меню с примерами интеграции Flutter из статьи
//

import SwiftUI

struct ExamplesMenuView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Основы FlutterEngine")) {
                    NavigationLink(destination: Example1_BasicEngine()) {
                        ExampleRow(
                            icon: "engine.combustion",
                            title: "1. Базовое создание",
                            color: .blue
                        )
                    }
                    
                    NavigationLink(destination: Example2_EngineReuse()) {
                        ExampleRow(
                            icon: "arrow.triangle.2.circlepath",
                            title: "2. Переиспользование",
                            color: .green
                        )
                    }
                }
                
                Section(header: Text("Управление")) {
                    NavigationLink(destination: Example3_LifecycleManagement()) {
                        ExampleRow(
                            icon: "gearshape.2",
                            title: "3. Жизненный цикл",
                            color: .orange
                        )
                    }
                }
                
                Section(header: Text("Расширенные возможности")) {
                    NavigationLink(destination: Example4_EngineGroup()) {
                        ExampleRow(
                            icon: "square.grid.2x2",
                            title: "4. EngineGroup",
                            color: .purple
                        )
                    }
                    
                    NavigationLink(destination: Example5_CustomEntrypoint()) {
                        ExampleRow(
                            icon: "arrow.right.circle",
                            title: "5. Кастомная точка входа",
                            color: .red
                        )
                    }
                }
                
                Section(header: Text("Варианты представления")) {
                    NavigationLink(destination: Example6_ModalPresentation()) {
                        ExampleRow(
                            icon: "rectangle.portrait.and.arrow.right",
                            title: "6. Модальное",
                            color: .cyan
                        )
                    }
                    
                    NavigationLink(destination: Example7_NavigationStack()) {
                        ExampleRow(
                            icon: "arrow.right.square",
                            title: "7. Навигационный стек",
                            color: .indigo
                        )
                    }
                    
                    NavigationLink(destination: Example8_SwiftUIIntegration()) {
                        ExampleRow(
                            icon: "square.stack.3d.up",
                            title: "8. SwiftUI интеграция",
                            color: .pink
                        )
                    }
                }
            }
            .navigationTitle("Примеры Flutter")
        }
    }
}

struct ExampleRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(color)
                .cornerRadius(6)
            
            Text(title)
        }
    }
}

#Preview {
    ExamplesMenuView()
        .environmentObject(AppDelegate())
}
