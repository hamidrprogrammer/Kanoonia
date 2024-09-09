package ir.kanoon.kanooniha.android

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.plugin.common.MethodChannel

class SignalRMessageReceiver(private val channel: MethodChannel) : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        // if (intent.action == "SignalRMessage") {
        //     val message = intent.getStringExtra("message")
        //     channel.invokeMethod("receiveMessage", message)
        // }
        if (intent.action == "CallNotif") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallNotif", message)
        }
        if (intent.action == "SendNotificationToAll") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("SendNotificationToAll", message)
        }
        if (intent.action == "SendNotificationToUser") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("SendNotificationToUser", message)
        }
        if (intent.action == "CallIncoming") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallIncoming", message)
        }
        if (intent.action == "CallUserList") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallUserList", message)
        }
        if (intent.action == "CallDeclined") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallDeclined", message)
        }

        if (intent.action == "ReceiveSignal") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("ReceiveSignal", message)
        }

        if (intent.action == "CallAccepted") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallAccepted", message)
        }
        if (intent.action == "CallEnded") {
            val message = intent.getStringExtra("message")
            channel.invokeMethod("CallEnded", message)
        }



    }
}