package ir.kanoon.kanooniha.android
import android.R
import android.annotation.SuppressLint
import android.content.Intent
import android.content.IntentFilter
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.net.Uri;
import android.os.Build
import android.os.Build.VERSION.SDK_INT
import android.os.Bundle;
import android.os.Parcelable
import android.util.Log
import android.widget.RemoteViews
import androidx.annotation.NonNull;
import com.google.gson.Gson
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import com.microsoft.signalr.HubConnectionState
import com.microsoft.signalr.TransportEnum
import io.reactivex.rxjava3.core.Single
import android.Manifest
import android.app.role.RoleManager
import android.content.Context
import android.content.pm.PackageManager
import android.os.PowerManager
import android.provider.Settings
import androidx.activity.result.ActivityResultLauncher
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat

class MainActivity : FlutterActivity() {
    private val CHANNEL = "ir.kanoon.kanooniha.android/messages"
    private lateinit var receiver: SignalRMessageReceiver
    companion object {
        private const val REQUEST_WRITE_STORAGE_PERMISSION = 100
        private const val REQUEST_READ_PHONE_STATE_PERMISSION = 101
        private val REQUEST_CODE_SET_DEFAULT_DIALER = 123
    }
    @RequiresApi(Build.VERSION_CODES.Q)
    private fun requestDefaultDialerRole() {
        val roleManager = getSystemService(Context.ROLE_SERVICE) as RoleManager
        if (!roleManager.isRoleHeld(RoleManager.ROLE_DIALER)) {
            val intent = roleManager.createRequestRoleIntent(RoleManager.ROLE_DIALER)
            startActivityForResult(intent, REQUEST_CODE_SET_DEFAULT_DIALER)
        } else {
            // The socket will handle the call status check
        }
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SET_DEFAULT_DIALER) {
            if (resultCode == RESULT_OK) {
                // Your app is now the default phone app
                // The socket will handle the call status check
            } else {
                // The user denied the request
                println("The user denied setting the app as default dialer.")
            }
        }
    }
    private fun checkPermissions() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
            != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                REQUEST_WRITE_STORAGE_PERMISSION
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_WRITE_STORAGE_PERMISSION) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                // Permission granted, you can perform the operation
            } else {
                // Permission denied, inform the user that storage access is needed
            }
        }
        if (requestCode == REQUEST_READ_PHONE_STATE_PERMISSION) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                Log.d("MainActivity", "READ_PHONE_STATE permission accept")
                // Permission granted, you can perform the operation
            } else {
                Log.d("MainActivity", "READ_PHONE_STATE permission denied")
                // Permission denied, inform the user that storage access is needed
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.e("Service", "configureFlutterEngine")
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE)
            != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.READ_PHONE_STATE),
                REQUEST_READ_PHONE_STATE_PERMISSION
            )
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent()
            val packageName = packageName
            val pm = getSystemService(PowerManager::class.java)
            if (!pm.isIgnoringBatteryOptimizations(packageName)) {
                intent.action = Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS
                intent.data = Uri.parse("package:$packageName")
                startActivity(intent)
            }
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            checkPermissions()
        }
        FileLog.startLogging(this)
        handleIntent(intent)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        receiver = SignalRMessageReceiver(channel)
        registerReceiver(receiver, IntentFilter("SendNotificationToAll"))
        registerReceiver(receiver, IntentFilter("SendNotificationToUser"))
        registerReceiver(receiver, IntentFilter("CallIncoming"))
        registerReceiver(receiver, IntentFilter("CallUserList"))
        registerReceiver(receiver, IntentFilter("CallDeclined"))
        registerReceiver(receiver, IntentFilter("ReceiveSignal"))
        registerReceiver(receiver, IntentFilter("CallAccepted"))
        registerReceiver(receiver, IntentFilter("CallEnded"))
        registerReceiver(receiver, IntentFilter("CallNotif"))

        channel.setMethodCallHandler { call, result ->
            Log.e("setMethodCallHandler",call.method)
            when (call.method) {
                "startService" -> {
                    val token = call.argument<String>("token")
                    startSignalRService(token)
                    result.success(null)
                    val intent = Intent(this, MySignalR::class.java)
                    intent.putExtra("enableShowNotift", "2")
                    intent.putExtra("stop", "1")
                    startService(intent)
                }
                "stopService" -> {
                    val intent = Intent(this, MySignalR::class.java)
                    intent.putExtra("stop", "2")
                    startService(intent)
                    stopToService()
                    result.success(null)

                }

                "sendMessage" -> {
                    val methodName = call.argument<String>("methodName")
                    val message =call.argument<String>("message")
                    sendMessageToService(methodName, message)
                    result.success(null)
                }
                "hangingUp" -> {

                    hangingUpToService("hangingUp")
                    result.success(null)
                }
                "sendSignal" -> {
                    val sdp = call.argument<String>("sdp")
                    val user =call.argument<String>("user")
                    if (sdp != null) {
                        Log.d("SPPPPPPPPPPPPPPPPPPPPPPP",sdp)
                    }else{
                        Log.d("SPPPPPPPPPPPPPPPPPPPPPPP","SPD IS NULLLLLLLLLLLLL")
                    }
                    sendSignalToService(sdp, user)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }


    }
//    private fun registerScreenReceiver() {
//        val filter = IntentFilter()
//        filter.addAction(Intent.ACTION_SCREEN_OFF)
//        filter.addAction(Intent.ACTION_SCREEN_ON)
//        registerReceiver(ScreenReceiver(), filter)
//    }


    private fun handleIntent(intent: Intent) {
        when (intent.action) {
            "OPEN_Call_AND_JOIN" -> {
                val serviceIntent = Intent(context, MySignalR::class.java)
                    serviceIntent.action = "OPEN_Call_AND_JOIN"
                    serviceIntent.putExtra("ID", "12")
                    context.startService(serviceIntent)
            }
            "OPEN_BROWSER_AND_JOIN" -> {
                val url = intent.getStringExtra("URL")
                val id = intent.getStringExtra("ID")
                val browserIntent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                browserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                context.startActivity(browserIntent)

                // Invoke the join method on the hubConnection
                val serviceIntent = Intent(context, MySignalR::class.java)
                serviceIntent.action = "JOIN_HUB"
                serviceIntent.putExtra("ID", id)
                context.startService(serviceIntent)
            }

        }
    }

    override fun onStart() {
        Log.e("Service", "onStart")
        super.onStart()

    }
    private fun stopToService() {
        val intent = Intent(this, MySignalR::class.java)
        stopService(intent)
    }
    private fun hangingUpToService(token: String?) {
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("hangingUpTo", token)
        startService(intent)
    }
    private fun startSignalRService(token: String?) {
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("token", token)
        startService(intent)
    }
    private fun sendSignalToService(methodName: String?, message: String?) {
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("sdp", methodName)
        intent.putExtra("user", message)
        startService(intent)
    }
    private fun sendMessageToService(methodName: String?, message: String?) {
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("methodName", methodName)
        intent.putExtra("message", message)
        startService(intent)
    }

    override fun onPause() {
        super.onPause();
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("enableShowNotift", "1")

        startService(intent)
    }



    override fun onResume() {
        super.onResume();
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("enableShowNotift", "2")

        startService(intent)
    }

    override fun onDestroy() {
        super.onDestroy()
        val intent = Intent(this, MySignalR::class.java)
        intent.putExtra("enableShowNotift", "1")

        startService(intent)
        unregisterReceiver(receiver)
    }
    }


//class ScreenReceiver : BroadcastReceiver() {
//    override fun onReceive(context: Context, intent: Intent) {
//        when (intent.action) {
//            Intent.ACTION_SCREEN_OFF -> {
//                // Screen is turned off
//            }
//            Intent.ACTION_SCREEN_ON -> {
//                // Screen is turned on
//            }
//        }
//    }
//}