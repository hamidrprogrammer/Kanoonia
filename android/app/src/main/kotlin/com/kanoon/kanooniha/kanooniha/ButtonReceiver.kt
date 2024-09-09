

package ir.kanoon.kanooniha.android

import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch


class ButtonReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
//        if (Intent.ACTION_BOOT_COMPLETED == intent.action) {
//            val serviceIntent = Intent(context, MySignalR::class.java)
//            serviceIntent.action = "RECONNECT_HUB"
//            serviceIntent.putExtra("ID", "id")
//            context.startService(serviceIntent)
//        }

        val action = intent.action
        val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancel(2)
        if (action == "OPEN_BROWSER_AND_JOIN") {
            val url = intent.getStringExtra("URL")
            val id = intent.getStringExtra("ID")
            if (url != null && id != null) {
                Log.d("SITTTTTTTTTTTTTTTT",id)
                // Open the browser with the dynamic URL
                val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                browserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(browserIntent)

                // Invoke the join method on the hubConnection
                val serviceIntent = Intent(context, MySignalR::class.java)
                serviceIntent.action = "JOIN_HUB"
                serviceIntent.putExtra("ID", id)
                context.startService(serviceIntent)
            } else {
                Log.e("NotificationReceiver", "URL is null")
            }
        }
            if (action == "OPEN_Call_AND_JOIN") {

                val id = intent.getStringExtra("ID")
                if (id != null) {
                    Log.e("NotificationReceiver", id)
                    // Open the browser with the dynamic URL
                    val activityIntent = Intent(
                        context,
                        MainActivity::class.java
                    )
                    activityIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    context.startActivity(activityIntent)
//                     Invoke the join method on the hubConnection
//                    val serviceIntent = Intent(context, MySignalR::class.java)
//                    serviceIntent.action = "OPEN_Call_AND_JOIN"
//                    serviceIntent.putExtra("ID", id)
//                    context.startService(serviceIntent)
                } else {
                    Log.e("NotificationReceiver", "URL is null")
                }
            }
                if (action == "CLOSE_Call_AND_JOIN") {

                    val id = intent.getStringExtra("ID")
                    if (id != null) {
                        // Open the browser with the dynamic URL


                        // Invoke the join method on the hubConnection
                        val serviceIntent = Intent(context, MySignalR::class.java)
                        serviceIntent.action = "CLOSE_Call_AND_JOIN"
                        serviceIntent.putExtra("ID", id)
                        context.startService(serviceIntent)
                    } else {
                        Log.e("CLOSE_Call_AND_JOIN", "URL is null")
                    }
                }
        notificationManager.cancel(2)

    }
}