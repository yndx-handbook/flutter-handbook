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
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val ENGINE_GROUP_1 = "group_engine_1"
private const val ENGINE_GROUP_2 = "group_engine_2"

/**
 * Пример 4: FlutterEngineGroup
 * 
 * Демонстрирует:
 * - Создание группы движков с общим пулом ресурсов
 * - Оптимизацию памяти при работе с несколькими движками
 * - Кэширование движков из группы
 * - Одновременную работу нескольких изолированных Flutter-интерфейсов
 * 
 * Соответствует разделу "Расширенные возможности: FlutterEngineGroup" статьи
 */
class Example4_FlutterEngineGroupActivity : ComponentActivity() {
    private var engineGroup: FlutterEngineGroup? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example4Content(
                        onCreateGroup = ::createEngineGroup,
                        onCreateEngine = ::createEngine,
                        isGroupCreated = { engineGroup != null },
                        isEngineCached = ::isEngineCached,
                        onOpenEngine = ::openEngine
                    )
                }
            }
        }
    }

    private fun createEngineGroup() {
        if (engineGroup == null) {
            engineGroup = FlutterEngineGroup(this)
            Log.i("Example4", "FlutterEngineGroup создана")
        }
    }

    private fun createEngine(engineId: String) {
        val cache = FlutterEngineCache.getInstance()
        if (engineGroup != null && !cache.contains(engineId)) {
            // Создаём движок из группы и кэшируем его
            val engine = engineGroup!!.createAndRunDefaultEngine(this)
            cache.put(engineId, engine)

            Log.i("Example4", "Создан движок: $engineId")
        }
    }

    private fun isEngineCached(engineId: String): Boolean {
        return FlutterEngineCache.getInstance().contains(engineId)
    }

    private fun openEngine(engineId: String) {
        startActivity(
            FlutterActivity.withCachedEngine(engineId)
                .build(this)
        )
    }

    override fun onDestroy() {
        super.onDestroy()
        // Очищаем кэш движков
        FlutterEngineCache.getInstance().apply {
            remove(ENGINE_GROUP_1)
            remove(ENGINE_GROUP_2)
        }
        engineGroup = null
    }
}

@Composable
fun Example4Content(
    onCreateGroup: () -> Unit,
    onCreateEngine: (String) -> Unit,
    isGroupCreated: () -> Boolean,
    isEngineCached: (String) -> Boolean,
    onOpenEngine: (String) -> Unit
) {
    var groupCreated by remember { mutableStateOf(false) }
    var engine1Cached by remember { mutableStateOf(false) }
    var engine2Cached by remember { mutableStateOf(false) }

    // Проверяем состояние кэша
    LaunchedEffect(Unit) {
        groupCreated = isGroupCreated()
        engine1Cached = isEngineCached(ENGINE_GROUP_1)
        engine2Cached = isEngineCached(ENGINE_GROUP_2)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "FlutterEngineGroup",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Несколько движков с общими ресурсами",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        // Статус группы
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(
                containerColor = if (groupCreated)
                    MaterialTheme.colorScheme.primaryContainer
                else
                    MaterialTheme.colorScheme.surfaceVariant
            )
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp)
            ) {
                Text(
                    text = if (groupCreated) "Группа создана" else "Группа не создана",
                    style = MaterialTheme.typography.titleMedium
                )
                if (engine1Cached || engine2Cached) {
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        text = "Движок 1: ${if (engine1Cached) "Движок в кэше" else "Движок не в кэше"} | " +
                                "Движок 2: ${if (engine2Cached) "Движок в кэше" else "Движок не в кэше"}",
                        style = MaterialTheme.typography.bodySmall
                    )
                }
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Кнопка создания группы
        Button(
            onClick = {
                onCreateGroup()
                groupCreated = true
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = !groupCreated
        ) {
            Text("1. Создать FlutterEngineGroup")
        }

        Spacer(modifier = Modifier.height(12.dp))


        Button(
            onClick = {
                onCreateEngine(ENGINE_GROUP_1)
                engine1Cached = true
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = groupCreated && !engine1Cached
        ) {
            Text("2. Создать движок #1")
        }

        Spacer(modifier = Modifier.height(8.dp))


        Button(
            onClick = {
                onCreateEngine(ENGINE_GROUP_2)
                engine2Cached = true
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = groupCreated && !engine2Cached
        ) {
            Text("3. Создать движок #2")
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Запуск Flutter с первым движком
        Button(
            onClick = { onOpenEngine(ENGINE_GROUP_1) },
            modifier = Modifier.fillMaxWidth(),
            enabled = engine1Cached
        ) {
            Text("Открыть Flutter с движком #1")
        }

        Spacer(modifier = Modifier.height(8.dp))

        // Запуск Flutter со вторым движком
        Button(
            onClick = { onOpenEngine(ENGINE_GROUP_2) },
            modifier = Modifier.fillMaxWidth(),
            enabled = engine2Cached
        ) {
            Text("Открыть Flutter с движком #2")
        }
    }
}

