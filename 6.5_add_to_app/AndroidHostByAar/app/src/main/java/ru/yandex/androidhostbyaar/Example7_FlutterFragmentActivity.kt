package ru.yandex.androidhostbyaar

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.unit.dp
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbyaar.ui.theme.AndroidHostByAarTheme

private const val FRAGMENT_ENGINE = "fragment_example_engine"
private const val FLUTTER_FRAGMENT_TAG = "flutter_fragment"

/**
 * Пример 7: FlutterFragment
 * 
 * Демонстрирует:
 * - Встраивание Flutter как фрагмента в существующий UI
 * - Использование с ViewPager, TabLayout и другими компонентами
 * - Гибкую интеграцию в архитектуру с фрагментами
 * 
 * Соответствует разделу "FlutterFragment" статьи
 */
class Example7_FlutterFragmentActivity : AppCompatActivity() {
    private var flutterFragment: FlutterFragment? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Создаём кэшированный движок
        if (!FlutterEngineCache.getInstance().contains(FRAGMENT_ENGINE)) {
            val engine = FlutterEngine(this)
            engine.navigationChannel.setInitialRoute("user")
            engine.dartExecutor.executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()
            )
            FlutterEngineCache.getInstance().put(FRAGMENT_ENGINE, engine)
        }

        // Создаём layout с Compose и контейнером для фрагмента
        setContentView(R.layout.activity_example7_fragment)

        // Показываем Flutter фрагмент
        if (savedInstanceState == null) {
            flutterFragment = FlutterFragment.withCachedEngine(FRAGMENT_ENGINE)
                .build()

            supportFragmentManager.beginTransaction()
                .add(R.id.fragment_container, flutterFragment!!, FLUTTER_FRAGMENT_TAG)
                .commit()
        } else {
            flutterFragment = supportFragmentManager
                .findFragmentByTag(FLUTTER_FRAGMENT_TAG) as? FlutterFragment
        }

        findViewById<ComposeView>(R.id.compose_info).apply {
            setContent {
                AndroidHostByAarTheme {
                    InfoCard()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        if (isFinishing) {
            FlutterEngineCache.getInstance().remove(FRAGMENT_ENGINE)
        }
    }

    @Composable
    fun InfoCard() {
        Surface(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            color = MaterialTheme.colorScheme.surfaceVariant,
            shape = MaterialTheme.shapes.medium
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Flutter Fragment встроен ниже",
                    style = MaterialTheme.typography.titleMedium
                )
            }
        }
    }
}

