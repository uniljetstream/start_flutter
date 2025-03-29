package com.example.start_book

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //메시지 채널 테스트
        val channel = BasicMessageChannel<String>(
            flutterEngine.dartExecutor,
            "myMessageChannel",
            StringCodec.INSTANCE
        )
        channel.setMessageHandler { message, reply ->
            Log.d("msg", "receive: $message")
            reply.reply("Reply from Android")
            channel.send("Hello from Android") { replay -> Log.d("msg", "reply : $replay") }    //send() 함수의 두번째 매개변수는 다트에서 반환하는 결과를 받는 함수
        }
    }
}
