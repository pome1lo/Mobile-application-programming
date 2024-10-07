package com.example.lw6

import android.bluetooth.BluetoothAdapter
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.BatteryManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    //private val CHANNEL = "com.example/bluetooth"
    //private val CHANNEL = "com.example/battery"
    private val CHANNEL = "com.example/browser"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }
                "getBluetoothStatus" -> {
                    val bluetoothStatus = getBluetoothStatus()
                    result.success(bluetoothStatus)
                }
                "launchBrowser" -> {
                    val url: String? = call.argument("url")
                    if (url != null) {
                        launchBrowser(url)
                        result.success(true)
                    } else {
                        result.error("INVALID_URL", "URL is null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    // Метод для открытия браузера с переданным URL
    private fun launchBrowser(url: String) {
        val intent = Intent(Intent.ACTION_VIEW)
        intent.setData(Uri.parse(url))
        startActivity(intent)
//        val resolvedActivity = intent.resolveActivity(packageManager)
//
//        if (resolvedActivity != null) {
//            println("Browser launched with URL: $url")
//        } else {
//            println("No activity found to handle the intent for URL: $url")
//        }
    }

    // Получение уровня заряда батареи
    private fun getBatteryLevel(): Int {
        val batteryIntent: Intent? = ContextWrapper(applicationContext).registerReceiver(
            null, IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        return batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
    }

    // Получение статуса Bluetooth
    private fun getBluetoothStatus(): Boolean {
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        return bluetoothAdapter?.isEnabled ?: false
    }
}