package com.example.fltr_pdascan

import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.rscja.deviceapi.RFIDWithUHF;

class MainKtActivity: FlutterActivity() {

    private val CHANNEL = "demo.uhf/scan"
    private var mReader : RFIDWithUHF? = null


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            // Note: this method is invoked on the main thread.
            if (call.method == "INIT") {
                try {
                    mReader =RFIDWithUHF.getInstance()

                    result.success(mReader.toString())
                } catch (ex: Exception) {
                    result.error("ERROR_INIT",null,null)
                }

            }
        }
    }
}

