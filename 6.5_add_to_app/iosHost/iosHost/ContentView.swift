//
//  ContentView.swift
//  iosHost
//
//  Created by Anton Prokofev on 13.04.2025.
//

import SwiftUI
import Flutter

struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        TabView {
            // Вкладка с примерами из статьи
            ExamplesMenuView()
                .tabItem {
                    Label("Примеры", systemImage: "book.fill")
                }
            
            // Вкладка с оригинальными демо
            OriginalDemoView()
                .tabItem {
                    Label("Демо", systemImage: "square.stack.3d.up.fill")
                }
        }
    }
}

// MARK: - Original Demo View

struct OriginalDemoView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @State private var showFlutter = false
    @State private var showFlutterFullScreen = false
    @State private var showCustomFlutter = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("iOS Host App")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Примеры интеграции Flutter")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                    .padding(.vertical)
                
                // Кнопка для модального Flutter-экрана
                Button(action: {
                    showFlutter.toggle()
                }) {
                    VStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.largeTitle)
                        Text("Модальный Flutter-экран")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .sheet(isPresented: $showFlutter) {
                    FlutterView()
                }
                
                // Кнопка для полноэкранного Flutter
                Button(action: {
                    showFlutterFullScreen.toggle()
                }) {
                    VStack {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .font(.largeTitle)
                        Text("Полноэкранный Flutter")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .fullScreenCover(isPresented: $showFlutterFullScreen) {
                    FlutterView()
                }
                
                // Кнопка для навигации к Flutter-экрану
                NavigationLink(destination: FlutterViewWrapper()) {
                    VStack {
                        Image(systemName: "arrow.right.circle")
                            .font(.largeTitle)
                        Text("Навигация к Flutter")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                
                // Кнопка для кастомного управления жизненным циклом
                Button(action: {
                    showCustomFlutter.toggle()
                }) {
                    VStack {
                        Image(systemName: "gearshape.2")
                            .font(.largeTitle)
                        Text("С управлением жизненным циклом")
                            .font(.headline)
                        Text("(смотри консоль)")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .sheet(isPresented: $showCustomFlutter) {
                    CustomFlutterView(onLog: { log in
                        print(log)
                    })
                }
                
                Spacer()
                
                // Информация о кэшировании
                VStack(alignment: .leading, spacing: 8) {
                    Text("ℹ️ Flutter Engine")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Text("• Движок предзагружен в AppDelegate")
                        .font(.caption)
                    Text("• Используется кэшированный экземпляр")
                        .font(.caption)
                    Text("• Быстрый старт без задержек")
                        .font(.caption)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Flutter View Wrapper

/// SwiftUI обёртка для FlutterViewController
struct FlutterView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        SafeFlutterView(engine: appDelegate.flutterEngine)
    }
}

/// Обёртка для использования в NavigationLink
struct FlutterViewWrapper: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        SafeFlutterView(engine: appDelegate.flutterEngine)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    ContentView()
        .environmentObject(AppDelegate())
}
