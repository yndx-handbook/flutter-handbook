//
//  AppDelegate.swift
//  iosHost
//
//  Created by Anton Prokofev on 13.04.2025.
//

import UIKit
import Flutter

class AppDelegate: FlutterAppDelegate, ObservableObject {
    // Основной движок для переиспользования
    lazy var flutterEngine = FlutterEngine(name: "flutter_engine")
    
    // Пример работы с FlutterEngineGroup для множественных движков
    var engineGroup: FlutterEngineGroup?
    var engines: [String: FlutterEngine] = [:]
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Запускаем основной движок заранее для быстрого старта
        print("🚀 [AppDelegate] Запуск Flutter Engine")
        flutterEngine.run()
        
        // Пример создания группы движков (раскомментируйте при необходимости)
        // setupEngineGroup()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - Application Lifecycle
    
    override func applicationWillResignActive(_ application: UIApplication) {
        // Приложение переходит в неактивное состояние
        print("⏸️ [AppDelegate] Приложение становится неактивным")
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Приложение ушло в фон
        print("📱 [AppDelegate] Приложение в фоне")
        
        // При необходимости можно освободить временные движки
        // clearTemporaryEngines()
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        // Приложение завершается - очищаем все ресурсы
        print("🛑 [AppDelegate] Приложение завершается - очистка ресурсов")
        
        // Очищаем основной движок
        flutterEngine.destroyContext()
        
        // Очищаем все дополнительные движки
        clearAllEngines()
        
        print("✅ [AppDelegate] Все Flutter ресурсы освобождены")
    }
    
    // MARK: - FlutterEngineGroup Setup
    
    /// Настройка группы движков для работы с несколькими Flutter-интерфейсами
    private func setupEngineGroup() {
        engineGroup = FlutterEngineGroup(name: "my_engine_group", project: nil)
        
        // Создаем и храним движки в словаре
        if let engine1 = engineGroup?.makeEngine(withEntrypoint: nil, libraryURI: nil) {
            engine1.run()
            engines["group_engine_1"] = engine1
        }
        
        if let engine2 = engineGroup?.makeEngine(withEntrypoint: nil, libraryURI: nil) {
            engine2.run()
            engines["group_engine_2"] = engine2
        }
    }
    
    // MARK: - Helper Methods
    
    /// Получить движок по ключу из кэша
    func getEngine(forKey key: String) -> FlutterEngine? {
        return engines[key]
    }
    
    /// Удалить движок из кэша (освобождение ресурсов)
    func removeEngine(forKey key: String) {
        engines.removeValue(forKey: key)
    }
    
    /// Очистить все движки
    func clearAllEngines() {
        engines.removeAll()
    }
}
