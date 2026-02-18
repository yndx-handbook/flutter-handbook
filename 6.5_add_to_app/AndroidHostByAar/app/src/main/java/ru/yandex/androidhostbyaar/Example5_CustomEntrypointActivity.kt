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
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val CUSTOM_ENGINE = "custom_entrypoint_engine"

/**
 * Пример 5: Кастомная точка входа
 * 
 * Демонстрирует:
 * - Запуск Flutter с пользовательской функцией (не main)
 * - Передачу аргументов в Dart-код при запуске
 * - Использование DartExecutor.DartEntrypoint
 * - Требует аннотации @pragma('vm:entry-point') во Flutter коде
 * 
 * Соответствует разделу "Запуск кастомной точки входа" статьи
 */
class Example5_CustomEntrypointActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example5Content()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        FlutterEngineCache.getInstance().remove(CUSTOM_ENGINE)
    }
}

@Composable
fun Example5Content() {
    val context = LocalContext.current
    var entrypoint by remember { mutableStateOf("main") }
    var arguments by remember { mutableStateOf("") }
    var isEngineCreated by remember { mutableStateOf(false) }

    LaunchedEffect(Unit) {
        isEngineCreated = FlutterEngineCache.getInstance().contains(CUSTOM_ENGINE)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Кастомная точка входа",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Запуск Flutter с пользовательской функцией",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        OutlinedTextField(
            value = entrypoint,
            onValueChange = { entrypoint = it },
            label = { Text("Точка входа") },
            placeholder = { Text("main, main2, userMain") },
            modifier = Modifier.fillMaxWidth(),
            enabled = !isEngineCreated,
            singleLine = true
        )

        Spacer(modifier = Modifier.height(12.dp))

        OutlinedTextField(
            value = arguments,
            onValueChange = { arguments = it },
            label = { Text("Аргументы (через запятую)") },
            placeholder = { Text("user_id, some_value") },
            modifier = Modifier.fillMaxWidth(),
            enabled = !isEngineCreated,
            singleLine = true
        )

        Spacer(modifier = Modifier.height(24.dp))

        // Индикатор статуса
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(
                containerColor = if (isEngineCreated)
                    MaterialTheme.colorScheme.primaryContainer
                else
                    MaterialTheme.colorScheme.surfaceVariant
            )
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.Center
            ) {
                Text(
                    text = if (isEngineCreated) "Движок запущен" else "Движок остановлен",
                    style = MaterialTheme.typography.titleMedium
                )
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Кнопка запуска с кастомной точкой входа
        Button(
            onClick = {
                if (!FlutterEngineCache.getInstance().contains(CUSTOM_ENGINE)) {
                    val flutterLoader = FlutterInjector.instance().flutterLoader()
                    
                    // Создаём кастомную точку входа
                    val customDartEntrypoint = DartExecutor.DartEntrypoint(
                        flutterLoader.findAppBundlePath(),
                        entrypoint.ifEmpty { "main" }
                    )

                    // Парсим аргументы
                    val args = if (arguments.isNotEmpty()) {
                        arguments.split(",").map { it.trim() }
                    } else {
                        emptyList()
                    }

                    // Создаём и запускаем движок
                    val engine = FlutterEngine(context)
                    engine.dartExecutor.executeDartEntrypoint(
                        customDartEntrypoint,
                        args
                    )

                    FlutterEngineCache.getInstance().put(CUSTOM_ENGINE, engine)
                    
                    Log.i("Example5", "Запущен с точкой входа: ${entrypoint}, аргументы: $args")
                    isEngineCreated = true
                }
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = !isEngineCreated
        ) {
            Text(if (isEngineCreated) "Движок уже создан" else "1. Запустить с кастомной точкой входа")
        }

        Spacer(modifier = Modifier.height(8.dp))

        Button(
            onClick = {
                context.startActivity(
                    FlutterActivity.withCachedEngine(CUSTOM_ENGINE)
                        .build(context)
                )
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isEngineCreated
        ) {
            Text("2. Открыть Flutter")
        }

        Spacer(modifier = Modifier.height(16.dp))

        OutlinedButton(
            onClick = {
                FlutterEngineCache.getInstance().remove(CUSTOM_ENGINE)
                Log.i("Example5", "Движок остановлен")
                isEngineCreated = false
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = isEngineCreated
        ) {
            Text("3. Остановить движок")
        }
    }
}

