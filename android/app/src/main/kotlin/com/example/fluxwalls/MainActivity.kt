package com.example.fluxwalls

import android.app.WallpaperManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.fluxwalls/wallpaper"
    private val executor = Executors.newSingleThreadExecutor()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "setWallpaper") {
                val path = call.argument<String>("path")
                val location = call.argument<Int>("location")

                if (path != null && location != null) {
                    // Run on background thread to avoid UI lag
                    executor.execute {
                        val success = setDirectly(path, location)
                        runOnUiThread {
                            if (success) result.success(null)
                            else result.error("ERROR", "Failed to set wallpaper", null)
                        }
                    }
                } else {
                    result.error("INVALID_ARGS", "Path or location is missing", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setDirectly(path: String, location: Int): Boolean {
        val wm = WallpaperManager.getInstance(this)
        val file = File(path)
        if (!file.exists()) return false

        return try {
            FileInputStream(file).use { stream ->
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                    val flags = when (location) {
                        1 -> WallpaperManager.FLAG_SYSTEM
                        2 -> WallpaperManager.FLAG_LOCK
                        else -> WallpaperManager.FLAG_SYSTEM or WallpaperManager.FLAG_LOCK
                    }
                    wm.setStream(stream, null, true, flags)
                } else {
                    // Fallback for older Android versions (Home only)
                    wm.setStream(stream)
                }
            }
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
}