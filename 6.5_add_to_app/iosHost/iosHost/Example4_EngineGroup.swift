//
//  Example4_EngineGroup.swift
//  iosHost
//
//  Пример 4: FlutterEngineGroup (строки 566-628)
//

import SwiftUI
import Flutter

struct Example4_EngineGroup: View {
    @State private var showEngine1 = false
    @State private var showEngine2 = false
    @State private var engineGroup: FlutterEngineGroup?
    @State private var engines: [String: FlutterEngine] = [:]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FlutterEngineGroup")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Множественные движки с общими ресурсами")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            if engineGroup == nil {
                Button("Создать группу движков") {
                    setupEngineGroup()
                }
                .buttonStyle(ExampleButtonStyle(color: .purple))
                .padding(.horizontal)
            } else {
                VStack(spacing: 12) {
                    Button("Открыть Flutter с движком #1") {
                        showEngine1 = true
                    }
                    .buttonStyle(ExampleButtonStyle(color: .blue))
                    
                    Button("Открыть Flutter с движком #2") {
                        showEngine2 = true
                    }
                    .buttonStyle(ExampleButtonStyle(color: .green))
                    
                    Button("Очистить группу") {
                        clearEngines()
                    }
                    .buttonStyle(ExampleButtonStyle(color: .red))
                }
                .padding(.horizontal)
                
                Text("Движков в группе: \(engines.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 4")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEngine1) {
            if let engine = engines["group_engine_1"] {
                SafeFlutterView(engine: engine)
            }
        }
        .sheet(isPresented: $showEngine2) {
            if let engine = engines["group_engine_2"] {
                SafeFlutterView(engine: engine)
            }
        }
    }
    
    private func setupEngineGroup() {
        engineGroup = FlutterEngineGroup(name: "demo_group", project: nil)
        
        if let engine1 = engineGroup?.makeEngine(withEntrypoint: nil, libraryURI: nil) {
            engine1.run()
            engines["group_engine_1"] = engine1
        }
        
        if let engine2 = engineGroup?.makeEngine(withEntrypoint: nil, libraryURI: nil) {
            engine2.run()
            engines["group_engine_2"] = engine2
        }
    }
    
    private func clearEngines() {
        engines.removeAll()
        engineGroup = nil
    }
}

#Preview {
    NavigationView {
        Example4_EngineGroup()
    }
}
