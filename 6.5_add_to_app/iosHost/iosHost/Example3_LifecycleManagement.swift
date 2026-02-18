//
//  Example3_LifecycleManagement.swift
//  iosHost
//
//  Пример 3: Управление жизненным циклом (строки 486-534)
//

import SwiftUI
import Flutter
import UIKit

struct Example3_LifecycleManagement: View {
    @State private var showFlutter = false
    @State private var logs: [String] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Управление жизненным циклом")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Ручное управление создание и уничтожением движка")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer()
            
            Button("Открыть с управлением жизненным циклом") {
                showFlutter = true
            }
            .buttonStyle(ExampleButtonStyle(color: .orange))
            .padding(.horizontal)
            
            // Логи
            if !logs.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(logs, id: \.self) { log in
                            Text(log)
                                .font(.system(.caption, design: .monospaced))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(height: 120)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Пример 3")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showFlutter) {
            CustomFlutterView(onLog: { logs.append($0) })
        }
    }
}

// MARK: - Custom Controller

class CustomFlutterViewController: UIViewController {
    private var flutterEngine: FlutterEngine?
    private var flutterViewController: FlutterViewController?
    var onLog: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLog?("✅ viewDidLoad: создание движка")
        
        flutterEngine = FlutterEngine(name: "lifecycle_engine")
        flutterEngine?.run()
        
        flutterViewController = FlutterViewController(
            engine: flutterEngine!,
            nibName: nil,
            bundle: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onLog?("📱 viewWillAppear: добавление в иерархию")
        
        if let flutterVC = flutterViewController {
            addChild(flutterVC)
            view.addSubview(flutterVC.view)
            flutterVC.view.frame = view.bounds
            flutterVC.didMove(toParent: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onLog?("👋 viewWillDisappear: удаление из иерархии")
        
        flutterViewController?.willMove(toParent: nil)
        flutterViewController?.view.removeFromSuperview()
        flutterViewController?.removeFromParent()
    }
    
    deinit {
        onLog?("🗑️ deinit: очистка ресурсов")
        flutterEngine = nil
        flutterViewController = nil
    }
}

struct CustomFlutterView: UIViewControllerRepresentable {
    let onLog: (String) -> Void
    
    func makeUIViewController(context: Context) -> CustomFlutterViewController {
        let controller = CustomFlutterViewController()
        controller.onLog = onLog
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CustomFlutterViewController, context: Context) {}
}

#Preview {
    NavigationView {
        Example3_LifecycleManagement()
    }
}
