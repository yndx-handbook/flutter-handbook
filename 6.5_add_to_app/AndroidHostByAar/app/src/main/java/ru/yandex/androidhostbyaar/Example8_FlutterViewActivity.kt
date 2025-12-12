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
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val VIEW_ENGINE = "view_example_engine"

/**
 * Пример 8: FlutterView
 *
 * Демонстрирует:
 * - Низкоуровневую интеграцию Flutter как View в Compose
 * - Комбинацию Flutter и нативных компонентов в одном экране
 * - Ручное управление жизненным циклом через attachToFlutterEngine/detachFromFlutterEngine
 * - Максимальную гибкость для кастомных сценариев
 *
 * Соответствует разделу "FlutterView" статьи
 */
class Example8_FlutterViewActivity : ComponentActivity() {
    private lateinit var flutterEngine: FlutterEngine

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val flutterLoader = FlutterInjector.instance().flutterLoader()

        // Создаём движок
        // Создаём кастомную точку входа
        val customDartEntrypoint = DartExecutor.DartEntrypoint(
            flutterLoader.findAppBundlePath(),
            "mainWidget"
        )

        // Создаём и запускаем движок
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            customDartEntrypoint,
            listOf("arg1", "arg2")
        )
        FlutterEngineCache.getInstance().put(VIEW_ENGINE, flutterEngine)

        Log.i("Example8", "FlutterEngine создан")

        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example8Content(flutterEngine)
                }
            }
        }
    }

    override fun onResume() {
        super.onResume()
        Log.i("Example8", "onResume: appIsResumed")
        flutterEngine.lifecycleChannel.appIsResumed()
    }

    override fun onPause() {
        super.onPause()
        Log.i("Example8", "onPause: appIsInactive")
        flutterEngine.lifecycleChannel.appIsInactive()
    }

    override fun onDestroy() {
        Log.i("Example8", "onDestroy: очистка ресурсов")
        FlutterEngineCache.getInstance().remove(VIEW_ENGINE)
        flutterEngine.destroy()
        super.onDestroy()
    }
}

@Composable
fun Example8Content(engine: FlutterEngine) {
    var flutterView: FlutterView? by remember { mutableStateOf(null) }

    Column(
        modifier = Modifier.fillMaxSize()
    ) {
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(
                containerColor = MaterialTheme.colorScheme.primaryContainer
            )
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Text(
                    text = "FlutterView в Compose",
                    style = MaterialTheme.typography.headlineMedium
                )
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = "Низкоуровневая интеграция",
                    style = MaterialTheme.typography.bodyMedium
                )
            }
        }

        // Flutter View встроенный в Compose (компактный размер)
        AndroidView(
            factory = { context ->
                FlutterView(context).apply {
                    Log.i("Example8", "Создание FlutterView и привязка к движку")
                    attachToFlutterEngine(engine)
                    flutterView = this
                }
            },
            modifier = Modifier
                .fillMaxWidth()
                .height(100.dp)
        )

        Surface(
            modifier = Modifier.fillMaxWidth(),
            color = MaterialTheme.colorScheme.surfaceVariant
        ) {
            Text(
                text = "FlutterView встроен выше с ручным управлением жизненным циклом",
                style = MaterialTheme.typography.bodyMedium,
                modifier = Modifier.padding(16.dp)
            )
        }
    }

    DisposableEffect(Unit) {
        onDispose {
            Log.i("Example8", "Отсоединение FlutterView от движка")
            flutterView?.detachFromFlutterEngine()
        }
    }
}

