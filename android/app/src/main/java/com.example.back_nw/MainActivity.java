//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//import io.flutter.embedding.engine.FlutterEngine;
//import androidx.annotation.NonNull;
//
//public class MainActivity extends FlutterActivity {
//    private static final String CHANNEL = "samples.flutter.dev/battery";
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//         MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            // Your existing code
//                        }
//                );
//    }
//}