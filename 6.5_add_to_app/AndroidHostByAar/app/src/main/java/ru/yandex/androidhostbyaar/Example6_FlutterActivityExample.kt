package ru.yandex.androidhostbyaar

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val ACTIVITY_ENGINE = "activity_example_engine"

/**
 * Пример 6: FlutterActivity
 * 
 * Демонстрирует:
 * - Запуск полноэкранного Flutter через FlutterActivity
 * - Различия между withNewEngine() и withCachedEngine()
 * - Использование initialRoute только с новыми движками
 * - Прозрачный фон (BackgroundMode.transparent) для анимаций и диалогов
 * 
 * Соответствует разделу "FlutterActivity" статьи
 */
class Example6_FlutterActivityExample : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Создаём кэшированный движок
        if (!FlutterEngineCache.getInstance().contains(ACTIVITY_ENGINE)) {
            val engine = FlutterEngine(this)
            engine.navigationChannel.setInitialRoute("user")
            engine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
            FlutterEngineCache.getInstance().put(ACTIVITY_ENGINE, engine)
        }
        
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example6Content()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        FlutterEngineCache.getInstance().remove(ACTIVITY_ENGINE)
    }
}

@Composable
fun Example6Content() {
    val context = LocalContext.current

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "FlutterActivity",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Полноэкранный Flutter-интерфейс",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Пример 1: Простой запуск
        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ACTIVITY_ENGINE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Запуск с кэшированным движком")
        }

        Spacer(modifier = Modifier.height(12.dp))

        // Пример 2: С новым движком и initialRoute
        // Примечание: initialRoute работает только с withNewEngine()!
        // withCachedEngine() не поддерживает initialRoute, т.к. движок уже запущен
        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ACTIVITY_ENGINE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Запуск с initialRoute")
        }

        Spacer(modifier = Modifier.height(12.dp))

        // Пример 3: Прозрачный фон
        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ACTIVITY_ENGINE)
                        .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Прозрачный фон")
        }
    }
}

