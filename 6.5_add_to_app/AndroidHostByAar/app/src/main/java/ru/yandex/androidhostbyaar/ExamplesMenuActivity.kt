package ru.yandex.androidhostbyaar

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

/**
 * Главное меню с примерами интеграции Flutter из статьи
 * 
 * Каждый пример демонстрирует конкретный способ работы с Flutter Engine,
 * описанный в статье "Интеграция Flutter в нативные приложения"
 */
class ExamplesMenuActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    ExamplesMenuContent()
                }
            }
        }
    }
}

@Composable
fun ExamplesMenuContent() {
    val context = LocalContext.current
    val scrollState = rememberScrollState()

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(scrollState),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Text(
            text = "Примеры интеграции Flutter",
            style = MaterialTheme.typography.headlineMedium,
            modifier = Modifier.padding(bottom = 8.dp)
        )

        Text(
            text = "Демонстрация примеров из статьи",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Divider(modifier = Modifier.padding(vertical = 8.dp))

        ExampleButton(
            title = "Пример 1: Базовое создание FlutterEngine",
            description = "Создание и запуск простого Flutter движка",
            onClick = {
                context.startActivity(Intent(context, Example1_BasicEngineActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 2: Кэширование FlutterEngine",
            description = "Предзагрузка и переиспользование движка для быстрого старта",
            onClick = {
                context.startActivity(Intent(context, Example2_EngineCacheActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 3: Управление жизненным циклом",
            description = "Ручное управление onCreate, onResume, onPause, onDestroy",
            onClick = {
                context.startActivity(Intent(context, Example3_LifecycleManagementActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 4: FlutterEngineGroup",
            description = "Создание нескольких движков с общим пулом ресурсов",
            onClick = {
                context.startActivity(Intent(context, Example4_FlutterEngineGroupActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 5: Кастомная точка входа",
            description = "Запуск Flutter с пользовательской функцией и аргументами",
            onClick = {
                context.startActivity(Intent(context, Example5_CustomEntrypointActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 6: FlutterActivity",
            description = "Полноэкранный Flutter, прозрачный фон, initialRoute",
            onClick = {
                context.startActivity(Intent(context, Example6_FlutterActivityExample::class.java))
            }
        )

        ExampleButton(
            title = "Пример 7: FlutterFragment",
            description = "Встраивание Flutter как фрагмента в существующий UI",
            onClick = {
                context.startActivity(Intent(context, Example7_FlutterFragmentActivity::class.java))
            }
        )

        ExampleButton(
            title = "Пример 8: FlutterView",
            description = "Низкоуровневая интеграция Flutter как View в Compose",
            onClick = {
                context.startActivity(Intent(context, Example8_FlutterViewActivity::class.java))
            }
        )

        Spacer(modifier = Modifier.height(16.dp))
    }
}

@Composable
fun ExampleButton(
    title: String,
    description: String,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        onClick = onClick
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = description,
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

