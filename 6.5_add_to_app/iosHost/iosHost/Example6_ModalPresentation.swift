//
//  Example6_ModalPresentation.swift
//  iosHost
//
//  Пример 6: Модальное представление (строки 796-807)
//

import SwiftUI
import Flutter

struct Example6_ModalPresentation: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @State private var showFlutter = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Модальное представление")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Показ Flutter как модального экрана")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            Button("Показать модально") {
                showFlutter = true
            }
            .buttonStyle(ExampleButtonStyle(color: .cyan))
            .padding(.horizontal)
            
            Text("present(flutterViewController, animated: true)")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 6")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFlutter) {
            SafeFlutterView(engine: appDelegate.flutterEngine)
        }
    }
}

#Preview {
    NavigationView {
        Example6_ModalPresentation()
            .environmentObject(AppDelegate())
    }
}
