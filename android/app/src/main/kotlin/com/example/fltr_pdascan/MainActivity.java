package com.example.fltr_pdascan;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import androidx.annotation.NonNull;

import com.rscja.deviceapi.RFIDWithUHF;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "demo.uhf/scan";
    public RFIDWithUHF mReader;


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        try {
            mReader = RFIDWithUHF.getInstance();
        }
        catch (Exception ex) {

            toastMessage(ex.getMessage());

            return;
        }
        if (mReader != null) {
            new InitTask().execute();
        }

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getBatteryLevel")) {


                            }
                        }
                );
    }

    @Override
    public void onPause() {
        Log.i("MY", "UHFReadTagFragment.onPause");
        super.onPause();

        // 停止识别
        stopInventory();
    }

    public void toastMessage(String msg) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show();
    }
}
