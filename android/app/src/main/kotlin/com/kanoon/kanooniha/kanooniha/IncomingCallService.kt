package ir.kanoon.kanooniha.android

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.IBinder
import androidx.core.app.NotificationCompat

class IncomingCallService : Service() {
    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val channelId = "ForegroundServiceChannel"
        val channel = NotificationChannel(channelId, "Foreground Service Channel", NotificationManager.IMPORTANCE_DEFAULT)
        val manager = getSystemService(NotificationManager::class.java)
        manager.createNotificationChannel(channel)

        val notification: Notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle("SignalR Service")
            .setContentText("Running SignalR connection")
            .setSmallIcon(R.drawable.launch_background)
            .build()

        startForeground(1, notification)

        // Initialize SignalR connection here

        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        // Clean up SignalR connection here
    }
}
