package ir.kanoon.kanooniha.android

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import android.widget.Toast

class PhoneStateReceiver : BroadcastReceiver() {

    @SuppressLint("UnsafeProtectedBroadcastReceiver")
    override fun onReceive(context: Context, intent: Intent) {
        val telephonyManager = context?.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        // Set up a listener to monitor call state changes
        val phoneStateListener = object : PhoneStateListener() {
            @Deprecated("Deprecated in Java")
            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
                when (state) {

                    TelephonyManager.CALL_STATE_OFFHOOK -> {
                        val serviceIntent = Intent(context, MySignalR::class.java)
                        serviceIntent.action = "PHONE_CALL_RECEIVED"
                        serviceIntent.putExtra("IDS", "id")
                        context.startService(serviceIntent)

                        // Call picked up (user accepted)
                        Toast.makeText(context, "Call accepted", Toast.LENGTH_SHORT).show()
                    }

                    TelephonyManager.CALL_STATE_IDLE -> {
                        // Call ended or missed (user declined or hung up)
                        Toast.makeText(context, "Call ended or declined", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }

        // Register the listener
        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
    }
}