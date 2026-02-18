//
//  Example7_NavigationStack.swift
//  iosHost
//
//  Пример 7: Навигационный стек (строки 809-820)
//

import SwiftUI
import Flutter

struct Example7_NavigationStack: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Навигационный стек")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Встраивание в UINavigationController")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: FlutterNavigationView()) {
                HStack {
                    Image(systemName: "arrow.right")
                    Text("Перейти к Flutter")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.indigo)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Text("navigationController?.pushViewController(flutterVC, animated: true)")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 7")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlutterNavigationView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        SafeFlutterView(engine: appDelegate.flutterEngine)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        Example7_NavigationStack()
            .environmentObject(AppDelegate())
    }
}
