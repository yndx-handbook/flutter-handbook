package ru.yandex.androidhostbyaar

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.FlutterInjector

/**
 * Кастомный Application класс для инициализации Flutter
 * 
 * Этот класс необходим для:
 * - Инициализации FlutterLoader при старте приложения
 * - Подготовки Flutter assets и ресурсов
 * - Корректной работы кастомных точек входа
 */
class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        
        // Инициализируем FlutterLoader при запуске приложения
        // Это необходимо для корректной работы всех Flutter компонентов
        FlutterInjector.instance().flutterLoader().startInitialization(this)
        FlutterInjector.instance().flutterLoader().ensureInitializationComplete(this, null)
    }
}

