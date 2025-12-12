package ru.yandex.androidhostbyaar

import android.os.Bundle
import android.util.Log
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
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val ENGINE_CACHE_EXAMPLE = "engine_cache_example"

/**
 * Пример 2: Кэширование и переиспользование FlutterEngine
 * 
 * Демонстрирует:
 * - Предзагрузку движка в FlutterEngineCache
 * - Быстрый старт благодаря кэшированию
 * - Переиспользование одного движка для нескольких экранов
 * - Удаление движка из кэша
 * 
 * Соответствует разделу "Кэширование на Android" статьи
 */
class Example2_EngineCacheActivity : ComponentActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example2Content()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        // Очищаем кэш при выходе из примера
        if (FlutterEngineCache.getInstance().contains(ENGINE_CACHE_EXAMPLE)) {
            FlutterEngineCache.getInstance().remove(ENGINE_CACHE_EXAMPLE)
        }
    }
}

@Composable
fun Example2Content() {
    val context = LocalContext.current
    var isCached by remember { mutableStateOf(false) }

    // Проверяем состояние кэша
    LaunchedEffect(Unit) {
        isCached = FlutterEngineCache.getInstance().contains(ENGINE_CACHE_EXAMPLE)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Кэширование FlutterEngine",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Предзагрузка для быстрого старта",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Индикатор статуса кэша
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(
                containerColor = if (isCached) 
                    MaterialTheme.colorScheme.primaryContainer 
                else 
                    MaterialTheme.colorScheme.errorContainer
            )
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.Center,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = if (isCached) "Движок в кэше" else "Движок не в кэше",
                    style = MaterialTheme.typography.titleMedium
                )
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Кнопка создания кэша
        Button(
            onClick = {
                if (!FlutterEngineCache.getInstance().contains(ENGINE_CACHE_EXAMPLE)) {
                    // Создаём движок
                    val engine = FlutterEngine(context)
                    
                    // Запускаем Dart код
                    engine.dartExecutor.executeDartEntrypoint(
                        DartExecutor.DartEntrypoint.createDefault()
                    )

                    // Кладём в кэш
                    FlutterEngineCache.getInstance().put(ENGINE_CACHE_EXAMPLE, engine)
                    
                    Log.i("Example2", "Движок создан и добавлен в кэш")
                    isCached = true
                }
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = !isCached
        ) {
            Text("1. Создать кэшированный движок")
        }

        Spacer(modifier = Modifier.height(12.dp))

        // Кнопки запуска Flutter
        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ENGINE_CACHE_EXAMPLE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isCached
        ) {
            Text("2. Открыть Flutter #1")
        }

        Spacer(modifier = Modifier.height(8.dp))

        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ENGINE_CACHE_EXAMPLE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isCached
        ) {
            Text("2. Открыть Flutter #2")
        }

        Spacer(modifier = Modifier.height(8.dp))

        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(ENGINE_CACHE_EXAMPLE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isCached
        ) {
            Text("2. Открыть Flutter #3")
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Кнопка удаления из кэша
        OutlinedButton(
            onClick = {
                if (FlutterEngineCache.getInstance().contains(ENGINE_CACHE_EXAMPLE)) {
                    FlutterEngineCache.getInstance().remove(ENGINE_CACHE_EXAMPLE)
                    Log.i("Example2", "Движок удалён из кэша")
                    isCached = false
                }
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isCached
        ) {
            Text("3. Удалить из кэша")
        }
    }
}

