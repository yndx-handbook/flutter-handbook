package ru.yandex.androidhostbyaar

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

/**
 * Пример 3: Управление жизненным циклом вручную
 * 
 * Демонстрирует:
 * - Ручное создание FlutterEngine в onCreate
 * - Привязку FlutterView к движку
 * - Управление состояниями через lifecycleChannel (appIsResumed, appIsInactive)
 * - Правильное освобождение ресурсов в onDestroy
 * 
 * Соответствует разделу "Управление жизненным циклом движка вручную" статьи
 */
class Example3_LifecycleManagementActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example3Content()
                }
            }
        }
    }
}

@Composable
fun Example3Content() {
    val context = LocalContext.current
    var logs by remember { mutableStateOf(listOf<String>()) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Управление жизненным циклом",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Ручное управление onCreate, onPause, onResume, onDestroy",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        Button(
            onClick = {
                context.startActivity(
                    android.content.Intent(context, CustomFlutterLifecycleActivity::class.java)
                )
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Открыть с управлением жизненным циклом")
        }

        Spacer(modifier = Modifier.height(16.dp))

        Text(
            text = "Логи будут выведены в консоль Android Studio",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}

/**
 * Кастомная Activity с ручным управлением жизненным циклом
 */
class CustomFlutterLifecycleActivity : AppCompatActivity() {
    private lateinit var flutterEngine: FlutterEngine
    private lateinit var flutterView: FlutterView
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        Log.i("Lifecycle", "onCreate: создание движка и FlutterView")
        
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        
        // Создаем FlutterView и привязываем к движку
        flutterView = FlutterView(this)
        flutterView.attachToFlutterEngine(flutterEngine)
        
        setContentView(flutterView)
    }
    
    override fun onResume() {
        super.onResume()
        Log.i("Lifecycle", "onResume: уведомляем Flutter (appIsResumed)")
        flutterEngine.lifecycleChannel.appIsResumed()
    }
    
    override fun onPause() {
        super.onPause()
        Log.i("Lifecycle", "⏸onPause: уведомляем Flutter (appIsInactive)")
        flutterEngine.lifecycleChannel.appIsInactive()
    }
    
    override fun onDestroy() {
        Log.i("Lifecycle", "onDestroy: отключаем View и уничтожаем движок")
        flutterView.detachFromFlutterEngine()
        flutterEngine.destroy()
        super.onDestroy()
    }
    
    override fun onBackPressed() {
        super.onBackPressed()
        Log.i("Lifecycle", "onBackPressed: пытаемся закрыть роут в Flutter")
        flutterEngine.navigationChannel.popRoute()
    }
}

