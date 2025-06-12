package com.example.base_template;

import io.flutter.embedding.android.FlutterActivity;
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager.LayoutParams

class MainActivity: FlutterFragmentActivity() {
	private val CHANNEL = "com.example.base_template/device_id"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
				MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceId" -> {
                    val androidId: String? = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.CUPCAKE) {
                        Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
                    } else {
                        null
                    }
                    if (androidId != null) {
                        result.success(androidId)
                    } else {
                        result.error("UNAVAILABLE", "Android ID not available", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
