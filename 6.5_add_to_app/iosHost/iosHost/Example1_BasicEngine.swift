//
//  Example1_BasicEngine.swift
//  iosHost
//
//  Пример 1: Базовое создание FlutterEngine (строки 278-302)
//

import SwiftUI
import Flutter

struct Example1_BasicEngine: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @State private var showFlutter = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Базовое создание FlutterEngine")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Движок создан в AppDelegate и готов к использованию")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            // Демонстрация
            Button(action: {
                showFlutter = true
            }) {
                HStack {
                    Image(systemName: "play.circle.fill")
                    Text("Открыть Flutter")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 1")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFlutter) {
            SafeFlutterView(engine: appDelegate.flutterEngine)
        }
    }
}

#Preview {
    NavigationView {
        Example1_BasicEngine()
            .environmentObject(AppDelegate())
    }
}
