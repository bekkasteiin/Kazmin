package kz.uco.kazmineralmobile

import io.flutter.embedding.android.FlutterActivity

import android.os.Build
import android.view.ViewTreeObserver
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

//class MainActivity: FlutterActivity() {
//}


class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}