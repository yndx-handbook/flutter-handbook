package ru.yandex.androidhostbyaar

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import io.flutter.embedding.android.FlutterActivity
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

/**
 * Пример 1: Базовое создание FlutterEngine
 * 
 * Демонстрирует:
 * - Создание нового движка при каждом запуске через FlutterActivity.withNewEngine()
 * - Самый простой способ запуска Flutter
 * 
 * Соответствует разделу "Создание движка на Android" статьи
 */
class Example1_BasicEngineActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            AndroidHostByAarTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Example1Content()
                }
            }
        }
    }
}

@Composable
fun Example1Content() {
    val context = LocalContext.current

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Базовое создание FlutterEngine",
            style = MaterialTheme.typography.headlineMedium
        )

        Spacer(modifier = Modifier.height(8.dp))

        Text(
            text = "Движок создаётся при каждом запуске",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        Spacer(modifier = Modifier.height(32.dp))

        Button(
            onClick = {
                // Создаём новый движок при каждом запуске
                context.startActivity(
                    FlutterActivity.withNewEngine().build(context)
                )
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(
                imageVector = androidx.compose.material.icons.Icons.Default.PlayArrow,
                contentDescription = null
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text("Открыть Flutter")
        }
    }
}

