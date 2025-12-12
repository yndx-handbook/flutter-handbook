package ru.yandex.androidhostbysource

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import io.flutter.FlutterInjector
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor
import ru.yandex.androidhostbysource.ui.theme.AndroidHostBySourceTheme

const val engineName = "flutter_host"


class MainActivity : ComponentActivity() {
    private lateinit var flutterEngine: FlutterEngine
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        io.flutter.Log.setLogLevel(io.flutter.Log.VERBOSE)
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        enableEdgeToEdge()
        setContent {
            AndroidHostBySourceTheme {
                MainActivityContent()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        FlutterEngineCache.getInstance().clear()
    }
}

@Composable
@Preview
fun MainActivityContent() {
    Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
        Greeting(
            name = "Android",
            modifier = Modifier.padding(innerPadding)
        )
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .fillMaxHeight()
                .padding(innerPadding),
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            CreateCachedEngineButton()
            DeleteCachedEngineButton()
            StartFlutterButton()
            StartTransparentFlutterButton()
        }
    }
}

@Composable
@Preview
fun CreateCachedEngineButton() {
    val context = LocalContext.current
    Button(onClick = {
        if (FlutterEngineCache.getInstance().contains(engineName).not()) {
            val group = FlutterEngineGroup(context)
            val flutterLoader = FlutterInjector.instance().flutterLoader()

            if (!flutterLoader.initialized()) {
                throw AssertionError(
                    "DartEntrypoints can only be created once a FlutterEngine is created."
                )
            }
            val flutterEngine: FlutterEngine =
                group.createAndRunEngine(
                    context,
                    DartExecutor.DartEntrypoint.createDefault(),
                )
            flutterEngine.addEngineLifecycleListener(object :
                FlutterEngine.EngineLifecycleListener {
                override fun onPreEngineRestart() {
                    Log.i("Engine", "engine restart");
                }

                override fun onEngineWillDestroy() {
                    Log.i("Engine", "engine will destroy");
                }

            })
            FlutterEngineCache.getInstance().put(engineName, flutterEngine)
            Toast.makeText(context, "created cached engine", Toast.LENGTH_SHORT).show()
        }
    }) {
        Text(text = "create cache")
    }
}

@Composable
fun DeleteCachedEngineButton() {
    val context = LocalContext.current
    Button(onClick = {
        if (FlutterEngineCache.getInstance().contains(engineName)) {
            FlutterEngineCache.getInstance().remove(engineName)
            Toast.makeText(context, "deleted cache engine", Toast.LENGTH_SHORT)
                .show()
        }
    }) {
        Text(text = "delete cache")
    }
}

@Composable
fun StartFlutterButton() {
    val context = LocalContext.current
    Button(onClick = {
        if (!FlutterEngineCache.getInstance().contains(engineName)) {
            val engine = FlutterEngine(context)
            val flutterLoader = FlutterInjector.instance().flutterLoader()
            val defaultDartEntrypoint = DartExecutor.DartEntrypoint.createDefault()
            Log.i("Engine", "default = $defaultDartEntrypoint")
            val customDartEntrypoint = DartExecutor.DartEntrypoint(
                flutterLoader.findAppBundlePath(),
                "main2"
            )

            Log.i("Engine", "custom = $customDartEntrypoint")

            engine.dartExecutor.executeDartEntrypoint(
                customDartEntrypoint,
                listOf("kotlin")
            )

            FlutterEngineCache.getInstance().put(engineName, engine)
        }


        context.startActivity(
            FlutterActivity.withCachedEngine(engineName)
                .build(context)
        )


    }) {
        Text(text = "run flutter")
    }
}

@Composable
fun StartTransparentFlutterButton() {
    val context = LocalContext.current

    Button(onClick = {
        context.startActivity(
            FlutterActivity.withCachedEngine(engineName)
                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                .build(context)
        )
    }) {
        Text(text = "run transparent flutter")
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Composable
fun GreetingPreview() {
    AndroidHostBySourceTheme {
        Greeting("Android")
    }
}