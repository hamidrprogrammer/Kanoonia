package ir.kanoon.kanooniha.android

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            val serviceIntent = Intent(context, MySignalR::class.java)
            context.startForegroundService(serviceIntent)
            Log.d("BootReceiver", "Service started on boot")
        }
    }
}