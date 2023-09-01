package com.example.finn_task

import android.bluetooth.BluetoothAdapter
import android.app.AlertDialog
import android.content.DialogInterface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity()  {
    private val CHANNEL = "your.neww.name" // Replace with your channel name

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "enableBluetooth") {
                enableBluetooth(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun enableBluetooth(result: MethodChannel.Result) {
        val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
        if (bluetoothAdapter != null) {
            if (!bluetoothAdapter.isEnabled) {
                val builder = AlertDialog.Builder(this)
                builder.setTitle("Enable Bluetooth")
                    .setMessage("Please enable Bluetooth to use this feature.")
                    .setPositiveButton("Settings") { dialog: DialogInterface, _: Int ->
                        bluetoothAdapter.enable()
                        result.success(true) // Return true indicating success
                    }
                    .setNegativeButton("Cancel") { _: DialogInterface, _: Int ->
                        result.success(false) // Return false indicating user canceled
                    }
                    .show()
            } else {
                result.success(false) // Return false indicating Bluetooth is already enabled
            }
        } else {
            result.error("BLUETOOTH_NOT_SUPPORTED", "Bluetooth is not supported on this device", null)
        }
    }
}
