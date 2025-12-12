//
//  Example8_SwiftUIIntegration.swift
//  iosHost
//
//  Пример 8: Интеграция в SwiftUI (строки 822-861)
//

import SwiftUI
import Flutter

struct Example8_SwiftUIIntegration: View {
    @EnvironmentObject var appDelegate: AppDelegate
    @State private var showSheet = false
    @State private var showFullScreen = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Интеграция в SwiftUI")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Использование UIViewControllerRepresentable")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            VStack(spacing: 12) {
                Button("Sheet (модально)") {
                    showSheet = true
                }
                .buttonStyle(ExampleButtonStyle(color: .pink))
                
                Button("FullScreenCover") {
                    showFullScreen = true
                }
                .buttonStyle(ExampleButtonStyle(color: .purple))
                
                NavigationLink(destination: FlutterInNavigationView()) {
                    Text("NavigationLink")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 8")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet) {
            FlutterSwiftUIView()
        }
        .fullScreenCover(isPresented: $showFullScreen) {
            FlutterSwiftUIView()
        }
    }
}

struct FlutterSwiftUIView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        SafeFlutterView(engine: appDelegate.flutterEngine)
    }
}

struct FlutterInNavigationView: View {
    @EnvironmentObject var appDelegate: AppDelegate
    
    var body: some View {
        SafeFlutterView(engine: appDelegate.flutterEngine)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        Example8_SwiftUIIntegration()
            .environmentObject(AppDelegate())
    }
}
