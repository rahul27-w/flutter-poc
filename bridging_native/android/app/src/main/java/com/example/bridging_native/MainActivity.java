package com.example.bridging_native;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "Native Channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith((FlutterEngine) flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("KEY_NATIVE")) {
                                String greetings = helloFromNativeCode();
                                Intent intent = new Intent(getApplicationContext(), NativeScreen.class);
                                startActivity(intent);
                                result.success(greetings);
                            }
                        });
    }

    private String helloFromNativeCode() {
        return "Hello from Native Android Code";
    }

}
