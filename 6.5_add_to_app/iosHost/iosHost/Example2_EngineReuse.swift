//
//  Example2_EngineReuse.swift
//  iosHost
//
//  Пример 2: Переиспользование FlutterEngine (строки 348-379)
//

import SwiftUI
import Flutter

struct Example2_EngineReuse: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @State private var showFlutter1 = false
    @State private var showFlutter2 = false
    @State private var showFlutter3 = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Переиспользование FlutterEngine")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Один движок для всех экранов")
                .foregroundColor(.secondary)
            
            Spacer()
            
            // Демонстрация
            VStack(spacing: 12) {
                Button("Открыть Flutter #1") {
                    showFlutter1 = true
                }
                .buttonStyle(ExampleButtonStyle(color: .blue))
                
                Button("Открыть Flutter #2") {
                    showFlutter2 = true
                }
                .buttonStyle(ExampleButtonStyle(color: .green))
                
                Button("Открыть Flutter #3") {
                    showFlutter3 = true
                }
                .buttonStyle(ExampleButtonStyle(color: .purple))
            }
            .padding(.horizontal)
            
            Text("Все экраны используют один движок")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 2")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFlutter1) {
            SafeFlutterView(engine: appDelegate.flutterEngine)
        }
        .sheet(isPresented: $showFlutter2) {
            SafeFlutterView(engine: appDelegate.flutterEngine)
        }
        .sheet(isPresented: $showFlutter3) {
            SafeFlutterView(engine: appDelegate.flutterEngine)
        }
    }
}

#Preview {
    NavigationView {
        Example2_EngineReuse()
            .environmentObject(AppDelegate())
    }
}
