package ir.kanoon.kanooniha.android

import android.Manifest
import android.annotation.SuppressLint
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.AudioAttributes
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.telecom.TelecomManager
import android.text.TextUtils
import android.util.Log
import android.widget.RemoteViews
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.google.gson.Gson
import com.google.gson.JsonArray
import com.google.gson.JsonParser
import com.google.gson.reflect.TypeToken
import com.microsoft.signalr.HubConnection
import com.microsoft.signalr.HubConnectionBuilder
import com.microsoft.signalr.HubConnectionState
import io.reactivex.rxjava3.core.Single
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import java.io.IOException
import java.io.InputStream
import java.net.HttpURLConnection
import java.net.URL
import java.util.concurrent.TimeUnit


class MySignalR : Service() {
    private val CHANNEL_ID = "kanoon"
    private var Call_Data = ""
    private var Call_Data_arg = ""

    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    private lateinit var sharedPreferencesHelper: SharedPreferencesHelper

    private val INCOMING_CALL_HANG_UP_REQUEST_ID = 1100
    private val NOTIFICATION_CHANEL_ID = "INCOMING_CALL_NOTIFICATION_CHANEL_ID"
    val INCOMING_CALL_REQUEST_ID: Int = 11
    val ANSWER_CALL_REQUEST_ID: Int = 22
    private val context: Context? = null
    val vibrationPattern: LongArray = longArrayOf(1000, 1000)
    private var soundUri: Uri? = null
    private var hubConnection: HubConnection? = null
    private val gson = Gson()
    private var token: String? = null
    var tokenOrg: String = ""

    var flagNotif = false;
    var flagStrt = true;
    var r: Ringtone? = null
    companion object {
        const val PERMISSION_NOTIFICATION_REQUEST_CODE = 6969

        const val EXTRA_TIME_START_CALL = "EXTRA_TIME_START_CALL"

        private const val NOTIFICATION_CHANNEL_ID_INCOMING = "callkit_incoming_channel_id"
        private const val NOTIFICATION_CHANNEL_ID_MISSED = "callkit_missed_channel_id"
    }

    private lateinit var notificationBuilder: NotificationCompat.Builder
    private var notificationViews: RemoteViews? = null
    private var notificationSmallViews: RemoteViews? = null
    private var notificationId: Int = 9696
    private var dataNotificationPermission: Map<String, Any> = HashMap()

    override fun onCreate() {
        super.onCreate()
        createNotificationChannelCall()
        createNotificationChannel()
       val notification = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
        r = RingtoneManager.getRingtone(applicationContext, notification)
        sharedPreferencesHelper = SharedPreferencesHelper(this)
        FileLog.startLogging(this)
    }

    @SuppressLint("NewApi", "MissingPermission", "LongLogTag")
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onCreate()
        FileLog.e("Service", "Service is running...")

//        Thread {
//            while (true) {
//                FileLog.e("Service", "Service is running...")
//                try {
//                    Thread.sleep(2000)
//                } catch (e: InterruptedException) {
//                    e.printStackTrace()
//                }
//            }
//        }.start()


        token = intent?.getStringExtra("token")

        val methodName = intent?.getStringExtra("methodName")
        val message = intent?.getStringExtra("message")
        val sdp = intent?.getStringExtra("sdp")
        val user = intent?.getStringExtra("user")
        val notif = intent?.getStringExtra("enableShowNotift")

        val hangingUpTo = intent?.getStringExtra("hangingUpTo")
        val id = intent?.getStringExtra("ID")
        val stop = intent?.getStringExtra("stop")
        if (intent?.action == "PHONE_CALL_RECEIVED") {
            val savedCallData = retrieveCallData()
            val savedCallDataJson = retrieveCallDataJson()
            sendMessageEnd("456879894", savedCallData.toString())
            val intent = Intent("CallDeclined")
            intent.putExtra("message", savedCallDataJson)
            sendBroadcast(intent)
            // Handle phone call received
        }
        if (stop != null) {

            if (stop =="2"){
                flagStrt =false
                stopService()
            }else{
                flagStrt =true
            }

        }
//        if (intent?.action == "RECONNECT_HUB") {
//            CoroutineScope(Dispatchers.Main).launch {
//                val value = sharedPreferencesHelper.getString("tokenKey")
//                if (value != null) {
//                    token = value
//                    flagStrt= true
//                }
//
//                // Do something with the retrieved value
//            }
//        }
        if(notif !=null){
            FileLog.i("ENABELLLLLLLLLLLLLLLL NOTIF",notif)
            if(notif =="1"){
                flagNotif = true
            }else{
                flagNotif = false
            }
        }
        if (intent?.action == "JOIN_HUB") {
            if (id != null) {
                invokeJoinHub(id)
            }

        }

        if (intent?.action == "OPEN_Call_AND_JOIN") {
           r?.stop()
            FileLog.i("OPEN_Call_AND_JOIN","OPEN_Call_AND_JOIN========================>")
            if (id != null) {
                FileLog.i("OPEN_Call_AND_JOIN",Call_Data)
                if(Call_Data !=""){


                val notificationManager = this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.cancel(2)


                val handlert = Handler(Looper.getMainLooper())
                handlert.postDelayed({
                    val intent = Intent("CallNotif")

                    intent.putExtra("message", Call_Data)
                    sendBroadcast(intent)
                    sendMessage("methodName",Call_Data)


                }, 3000)
            }
            }
        }
        if (intent?.action == "CLOSE_Call_AND_JOIN") {
            r?.stop()
            if (id != null) {
                sendMessageEnd(Call_Data,Call_Data)
            }
            return START_STICKY
        }
        if (hangingUpTo != null) {

            hangingUpToSignal()

        }
        if (sdp != null) {
            if (user != null) {
                sendSignal(sdp, user)
            };
        }
        if (methodName == "CallAnswer") {
            if (message != null) {
                sendMessage(methodName, Call_Data)
            };
        } else {

                if (methodName != null) {
                    sendMessageEnd(methodName, Call_Data)
                }

        }

        if (token != null && flagStrt ) {
//            CoroutineScope(Dispatchers.Main).launch {
//                sharedPreferencesHelper.deleteString("tokenKey")
//                sharedPreferencesHelper.saveString("tokenKey", token!!)
//            }

            tokenOrg= token as String


            if (hubConnection?.connectionState   == HubConnectionState.CONNECTED) {
                Log.i("INFO", "Hub connection is already running. Skipping reconnection.")
                return START_STICKY
            }
            val notification: android.app.Notification = NotificationCompat.Builder(this, CHANNEL_ID)
                    .setContentTitle("Foreground Service")
                    .setContentText("Service is running in the background")
                    .setPriority(NotificationCompat.PRIORITY_LOW)
                    .setVisibility(NotificationCompat.VISIBILITY_SECRET)
                    .build()

            startForeground(1, notification)
            startConnection(token!!)
            scope.launch {
                while (isActive) {
                    try {
                    if (hubConnection?.connectionState  != HubConnectionState.CONNECTED) {
                        println("SignalR is not connected. Attempting to connect..."+tokenOrg)
                        println("START"+ tokenOrg)
                        FileLog.i("STARTm",tokenOrg);
                        FileLog.i("STARTm","SignalR is not connected. Attempting to connect..."+tokenOrg);
                        startConnection(tokenOrg)

//                            startConnection(tokenOrg!!)




                    } else {
                        println("SignalR is already connected.")
                        FileLog.i("STARTm","SignalR is already connected.");
                    }
                    delay(5000) // 5 seconds delay before next check
                    } catch (e: Exception) {
                        FileLog.i("STARTm",e.toString());
                        startConnection(tokenOrg)
                    }
                }
            }


        }
        Log.i("START", "hubConnection?.start()")
        FileLog.i("STARTm","hubConnection?.start()");
        return START_STICKY
    }
    private fun retrieveCallData(): String? {
        val sharedPreferences: SharedPreferences = getSharedPreferences("CallDataPrefs", Context.MODE_PRIVATE)
        return sharedPreferences.getString("Call_Data", null)
    }
    private fun retrieveCallDataJson(): String? {
        val sharedPreferences: SharedPreferences = getSharedPreferences("CallDataPrefs", Context.MODE_PRIVATE)
        return sharedPreferences.getString("Call_Data_JSON", null)
    }
    @RequiresApi(Build.VERSION_CODES.P)
    private fun declineCallWithRetry() {

    }
    private val maxRetryAttempts = 5
    private var retryAttempts = 0
    private fun stopService() {
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.stop()
        }
        stopSelf()
    }
    fun startConnection(tok : String) {
        tokenOrg= tok
        println("startConnection()")
        FileLog.i("STARTm","startConnection()");
        println(tokenOrg)


        try {
            hubConnection = HubConnectionBuilder.create("https://app.kanoon.ir/api/ConnectionHub")

                    .withAccessTokenProvider(
                            Single.defer { Single.just(tokenOrg!!) }
                    )
                    .build()

            hubConnection?.start()?.doOnComplete {
                val intent = Intent("SignalRMessage")
                intent.putExtra("message", "Connected to the SignalR hub successfully.")
                sendBroadcast(intent)
                hubConnection?.invoke("join")
                    ?.subscribe(
                        { FileLog.i("join", "Message sent successfully") },
                        { error -> FileLog.i("join", "Error sending message"+ error.message.toString()) }
                    )
                println("Connected to the SignalR hub successfully.")

            }?.blockingAwait()

            hubConnection?.onClosed { exception ->
                if (exception != null) {
                    FileLog.i("STARTm","Disconnected from the SignalR hub due to an error: ${exception.message}");
                    println( "Disconnected from the SignalR hub due to an error: ${exception.message}")
                } else {
                    println( "Disconnected from the SignalR hub.")
                    FileLog.i("STARTm","Disconnected from the SignalR hub.");

                }
//                attemptReconnect(tok);
            }

            // Listeners for different client methods
            hubConnection?.on("SendNotificationToAll", { args ->
                println( "SendNotificationToAll")


                val intent = Intent("SendNotificationToAll")
                val json = gson.toJson(args)
                if(args.url == null){
                    args.icon?.let { it1 -> sendNotificationWithoutUrl(args.id,args.title, args.body,  it1) }
                } else {
                    args.url.let { args.icon?.let { it1 -> sendNotification(args.id,args.title, args.body, it, it1) } };

                }
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)
            }, Notification::class.java)
            hubConnection?.on("SendNotificationToGroup", { args ->
                Log.i("INFO", "SendNotificationToGroup")
                Log.i("INFO", args.toString())

                val intent = Intent("SendNotificationToGroup")
                val json = gson.toJson(args)
                if(args.url == null){
                    args.icon?.let { it1 -> sendNotificationWithoutUrl(args.id,args.title, args.body,  it1) }
                } else {
                    args.url.let { args.icon?.let { it1 -> sendNotification(args.id,args.title, args.body, it, it1) } };

                }
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)
            }, Notification::class.java)

            hubConnection?.on("SendNotificationToUser", { args ->
                Log.i("INFO", "SendNotificationToUser")

                val intent = Intent("SendNotificationToUser")
                val json = gson.toJson(args)
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)
            }, List::class.java)

            hubConnection?.on("CallUserList", { args ->
                Log.i("INFO", "CallUserList")


                val intent = Intent("CallUserList")
                val json = gson.toJson(args)
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)
            }, List::class.java)

            hubConnection?.on("CallIncoming", { args ->
                Log.i("INFO", "CallIncoming")
                val json = gson.toJson(args)
                Call_Data = args.userIdHash
                val sharedPreferences: SharedPreferences = getSharedPreferences("CallDataPrefs", Context.MODE_PRIVATE)
                val editor = sharedPreferences.edit()

                // Save Call_Data and its JSON representation
                editor.putString("Call_Data", Call_Data.toString())
                editor.putString("Call_Data_JSON", json)

                editor.apply();

                val savedCallData = retrieveCallData()
                println("Retrieved Call_Data: $savedCallData")
                if(flagNotif){
                   r?.play()
                    showIncomingNotification(args.userIdHash,args.username,args.username,json.toString())
                    val handler = Handler(Looper.getMainLooper())

                    // Delay time in milliseconds (40 seconds)
                    val delayMillis: Long = 40000

                    // Scheduling the function to run after 40 seconds
                    handler.postDelayed({
                        r?.stop() // Your function to be executed
                    }, delayMillis)
                }else{
                    val intent = Intent("CallIncoming")

                    intent.putExtra("message", json.toString())
                    sendBroadcast(intent)
                }



            }, CallUser::class.java)
            hubConnection?.on("CallDeclined", { args: Any, args3: Any ->
                r?.stop()
                Log.i("INFO", "CallDeclined")
                val intent = Intent("CallDeclined")
                val json = gson.toJson(args)
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)

                val notificationManager = this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.cancel(2)
            }, Any::class.java, Any::class.java)
            hubConnection?.on("ReceiveSignal", { args: Any, args3: Any ->
                Log.i("INFO", "ReceiveSignal")
                val intent = Intent("ReceiveSignal")
                val json = gson.toJson(args)
                val json3 = gson.toJson(args3)
                val jsonArray = JsonArray()
                jsonArray.add(JsonParser.parseString(json))
                jsonArray.add(JsonParser.parseString(json3))

                // Convert JSON array to string
                val jsonArrayString = jsonArray.toString()
                intent.putExtra("message", jsonArrayString)
                sendBroadcast(intent)

            }, Any::class.java, Any::class.java)
            hubConnection?.on("CallAccepted", { args: Any, args3: Any ->
                r?.stop()
                Log.i("INFO", "CallAccepted")
                val intent = Intent("CallAccepted")
                val json = gson.toJson(args)
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)
            }, Any::class.java, Any::class.java)
            hubConnection?.on("CallEnded", { args: Any, args3: Any ->
                r?.stop()
                Log.i("INFO", "CallEnded")
                val intent = Intent("CallDeclined")
                val json = gson.toJson(args)
                intent.putExtra("message", json.toString())
                sendBroadcast(intent)

                val notificationManager = this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
                notificationManager.cancel(2)
            }, Any::class.java, Any::class.java)

            FileLog.i("START", "hubConnection?.start()")


            // if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            //     hubConnection?.invoke("join")
            // } else {
            //     println( "Connection not established. Unable to invoke 'join'.")
            // }
        } catch (e: Exception) {
            println( "Error setting up hub connection: ${e.message}")
        }

    }
    private fun attemptReconnect(tokn :String) {
        if (retryAttempts < maxRetryAttempts) {
            retryAttempts++
            FileLog.i("INFO", "Attempting to reconnect... Attempt $retryAttempts of $maxRetryAttempts")
            try {
                TimeUnit.SECONDS.sleep(5) // Wait for 5 seconds before reconnecting
                if(flagStrt){
                    startConnection(tokn)
                }

            } catch (e: InterruptedException) {
                FileLog.e("ERROR", "Reconnection attempt interrupted: ${e.message}")
            }
        } else {
            FileLog.e("ERROR", "Maximum reconnection attempts reached. Connection failed.")
        }
    }
    @SuppressLint("CheckResult")
    private fun invokeJoinHub(id: String) {
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.invoke("SendNotificationDetail",id)
                    ?.subscribe(
                            { FileLog.i("SendNotificationDetail", "Message sent successfully") },
                            { error -> FileLog.e("hangUp", error.toString()) }
                    )
        }
    }
    @SuppressLint("CheckResult")
    private fun hangingUpToSignal() {
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.invoke("hangUp")
                    ?.subscribe(
                            { FileLog.i("hangUp", "Message sent successfully") },
                            { error -> FileLog.e("hangUp",  error.toString()) }
                    )
        }
    }

    @SuppressLint("CheckResult")
    private fun sendMessage(methodName: String, message: String) {
        FileLog.i("OPEN_Call_AND_JOIN_SEND","sendMessage=============>")
        FileLog.i("OPEN_Call_AND_JOIN_SEND",message)
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.invoke("CallAnswer", true, message, true)
                    ?.subscribe(
                            { FileLog.i("SignalRService", "Message sent successfully") },
                            { error -> FileLog.e("SignalRService", error.toString()) }
                    )
        }
    }

    @SuppressLint("CheckResult")
    private fun sendMessageEnd(methodName: String, message: String) {
        FileLog.i("OPEN_Call_AND_JOIN_SEND","sendMessage=============>")
        FileLog.i("OPEN_Call_AND_JOIN_SEND",message)
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.invoke("CallAnswer", false, message, false)
                    ?.subscribe(
                            { FileLog.i("SignalRService", "Message sent successfully") },
                            { error -> FileLog.e("SignalRService", error.toString()) }
                    )
        }
    }

    @SuppressLint("CheckResult")
    private fun sendSignal(sdp: String, user: String) {
        if (hubConnection?.connectionState == HubConnectionState.CONNECTED) {
            hubConnection?.invoke("CallSendSignal", sdp, user)
                    ?.subscribe(
                            { FileLog.i("CallSendSignal", "Message sent successfully") },
                            { error -> FileLog.e("CallSendSignal",  error.toString()) }
                    )
        }
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onDestroy() {
//        hubConnection.stop()
        super.onDestroy()
    }

    private inline fun <reified T> parseData(args: Any): T {
        val json = gson.toJson(args)
        return gson.fromJson(json, object : TypeToken<T>() {}.type)
    }

    private fun handleSendNotificationToAll(data: List<Notification>) {
        data.forEach {
            FileLog.i("SendNotificationToAll", "Notification: $it")
            val intent = Intent("SendNotificationToAll")
            intent.putExtra("message", it.toString())
            sendBroadcast(intent)
        }
    }

    private fun handleSendNotificationToUser(data: List<Notification>) {
        data.forEach {
            FileLog.i("SendNotificationToUser", "Notification: $it")
            val intent = Intent("SendNotificationToUser")
            intent.putExtra("message", it.toString())
            sendBroadcast(intent)
        }
    }

    private fun handleCallUserList(data: List<List<CallUser>>) {
        data.forEach { callUserList ->
            callUserList.forEach {
                FileLog.i("CallUserList", "CallUser: $it")
                val intent = Intent("CallUserList")
                intent.putExtra("message", it.toString())
                sendBroadcast(intent)
            }
        }
    }

    private fun handleCallIncoming(data: CallUser) {
        FileLog.i("CallIncoming", "CallUser: $data")

    }
    private fun createNotificationChannelCall() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "KANOON CALL"
            val descriptionText = "This is an example channel"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(CHANNEL_ID+"1", name, importance).apply {
                description = descriptionText
                setSound(null, null)
            }
            val notificationManager: NotificationManager =
                    getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    @SuppressLint("MissingPermission")
    private fun sendNotificationCall(id: String, title: String, message: String, s: String) {
        FileLog.e("eeeeeeeeeeeeNOTIF",flagNotif.toString())
        if(!flagNotif){
            return
        }
//try{
//
//        val notificationIntent = Intent(this, MainActivity::class.java)
//        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)
//        Log.i("INFO", "CallIncoming"+s)
//
//        val actionIntent = Intent(this, ButtonReceiver::class.java).apply {
//            action = "OPEN_Call_AND_JOIN"
//            putExtra("ID", id)
//        }
//        val declineIntent = Intent(this, ButtonReceiver::class.java).apply {
//            action = "CLOSE_Call_AND_JOIN"
//            putExtra("ID", id)
//
//        }
//    val notifyIntent = Intent(this, MainActivity::class.java).apply {
//        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
//    }.apply {
//        action = "OPEN_Call_AND_JOIN"
//
//
//    }
//    val notifyPendingIntent = PendingIntent.getActivity(
//        this, 0, notifyIntent,
//        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
//    )
//        val declinePendingIntent = PendingIntent.getBroadcast(
//                this, 0, declineIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
//        )
//        val actionPendingIntent = PendingIntent.getBroadcast(this, 1, actionIntent, PendingIntent.FLAG_IMMUTABLE)
//        val incomingCaller = Person.Builder()
//        .setName(title)
//        .setImportant(true)
//        .build()
//        val builder = NotificationCompat.Builder(this, CHANNEL_ID+"1")
//                .setSmallIcon(R.drawable.app_icon)
//                .setContentTitle("شما یک تماس دارید از طرف")
//
//
//                .setSound(null)
//            .setAutoCancel(true)
//            .setCategory(NotificationCompat.CATEGORY_MISSED_CALL)
//
//                .setPriority(NotificationCompat.PRIORITY_HIGH)
//
//            .addAction(R.drawable.app_icon, "Decline", declinePendingIntent)  // Add button here
//            .addAction(R.drawable.app_icon, "Accept", notifyPendingIntent)  // Add button here
//
//                 // Add button here
////        val uuid = UUID.randomUUID()
////        val mostSigBits = uuid.mostSignificantBits
////        val leastSigBits = uuid.leastSignificantBits
//        with(NotificationManagerCompat.from(this)) {
//            notify(2, builder.build())
//        }
//    } catch (e: InterruptedException) {
//        FileLog.e("ERROR", "Reconnection attempt interrupted: ${e.message}")
//    }
    }
    @SuppressLint("RemoteViewLayout")
    @Suppress("DEPRECATION")
    private fun getIncomingCallNotificationView(): RemoteViews {
        val incomingCallNotificationView: RemoteViews = RemoteViews(this.getPackageName(), R.layout.activity_incoming_call)
        val answerCallIntent: Intent = Intent(this, MainActivity::class.java)

        val answerCallPendingIntent = PendingIntent.getActivity(
                this, ANSWER_CALL_REQUEST_ID, answerCallIntent, PendingIntent.FLAG_UPDATE_CURRENT
        )
        val actionIntent = Intent(this, ButtonReceiver::class.java).apply {
            action = "OPEN_BROWSER_AND_JOIN"
            putExtra("URL", "s")
            putExtra("ID", "id")
        }
        val actionPendingIntent = PendingIntent.getBroadcast(this, 0, actionIntent, PendingIntent.FLAG_IMMUTABLE)


        incomingCallNotificationView.setOnClickPendingIntent(R.id.answer_call_button, answerCallPendingIntent)
        incomingCallNotificationView.setOnClickPendingIntent(R.id.hang_up_button, actionPendingIntent)
        return incomingCallNotificationView
    }
    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "KANNON"
            val descriptionText = "This is an example channel"
            val importance = NotificationManager.IMPORTANCE_LOW
            val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
                description = descriptionText
            }
            val notificationManager: NotificationManager =
                    getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
    private fun bitmap(strURL:String): Bitmap? {
        try {
            val url = URL(strURL)
            val connection = url.openConnection() as HttpURLConnection
            connection.doInput = true
            connection.connect()
            val input: InputStream = connection.inputStream
            val myBitmap = BitmapFactory.decodeStream(input)
            return myBitmap
        } catch (e: IOException) {
            e.printStackTrace()
            return null
        }
    }
    @SuppressLint("MissingPermission")
    private fun sendNotification(id: String, title: String, message: String, s: String,image: String) {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)


        val notifyIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }.apply {
            action = "OPEN_BROWSER_AND_JOIN"
            putExtra("URL", s)
            putExtra("ID", id)
        }
       val notifyPendingIntent = PendingIntent.getActivity(
            this, 0, notifyIntent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val builder = NotificationCompat.Builder(this,  CHANNEL_ID+"1")
                .setSmallIcon(R.drawable.app_icon)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setStyle(NotificationCompat.BigPictureStyle().bigPicture(bitmap(image)))
                .setAutoCancel(false)
                .addAction(R.drawable.app_icon, "Open Browser", notifyPendingIntent)  // Add button here

        with(NotificationManagerCompat.from(this)) {
            notify(3, builder.build())
        }
    }
    @SuppressLint("MissingPermission")
    private fun sendNotificationWithoutUrl(id: String, title: String, message: String,image: String) {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)



        val builder = NotificationCompat.Builder(this,  CHANNEL_ID+"1")
                .setSmallIcon(R.drawable.app_icon)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .setContentIntent(pendingIntent)
                .setStyle(NotificationCompat.BigPictureStyle().bigPicture(bitmap(image)))
                .setAutoCancel(true)
                // Add button here

        with(NotificationManagerCompat.from(this)) {
            notify(2, builder.build())
        }
    }
    @SuppressLint("MissingPermission")
    private fun sendNotificationWithoutImage(id: String, title: String, message: String) {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)



        val builder = NotificationCompat.Builder(this,  CHANNEL_ID+"1")
                .setSmallIcon(R.drawable.app_icon)
                .setContentTitle(title)
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                .setContentIntent(pendingIntent)
                .setAutoCancel(true)
        // Add button here

        with(NotificationManagerCompat.from(this)) {
            notify(2, builder.build())
        }
    }
    @SuppressLint("MissingPermission")
    fun showIncomingNotification(id: String, title: String, message: String, s: String) {
        FileLog.e("eeeeeeeeeeeeNOTIF",flagNotif.toString())
        if(!flagNotif){
            return
        }
        val builder = NotificationCompat.Builder(this, CHANNEL_ID+"1")



        builder.setAutoCancel(false)
        builder.setDefaults(NotificationCompat.DEFAULT_VIBRATE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            builder.setCategory(NotificationCompat.CATEGORY_CALL)
            builder.priority = NotificationCompat.PRIORITY_MAX
        }
        builder.setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
        builder.setOngoing(true)
        builder.setWhen(0)
//        notificationBuilder.setTimeoutAfter(
//            data.getLong(
//                CallkitConstants.EXTRA_CALLKIT_DURATION,
//                0L
//            )
//        )
        builder.setOnlyAlertOnce(true)
        builder.setSound(null)



        var smallIcon = this.applicationInfo.icon

        smallIcon = R.drawable.ic_accept

        builder.setSmallIcon(smallIcon)



            notificationViews =
                RemoteViews(this.packageName, R.layout.layout_custom_notification)
            initNotificationViews(notificationViews!!,  id, title, message, s)

            if ((Build.MANUFACTURER.equals(
                    "Samsung",
                    ignoreCase = true
                ) && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) || false
            ) {
                notificationSmallViews =
                    RemoteViews(this.packageName, R.layout.layout_custom_small_ex_notification)
                initNotificationViews(notificationSmallViews!!,  id, title, message, s)
            } else {
                notificationSmallViews =
                    RemoteViews(this.packageName, R.layout.layout_custom_small_notification)
                initNotificationViews(notificationSmallViews!!,  id, title, message, s)
            }

            builder.setStyle(NotificationCompat.DecoratedCustomViewStyle())
            builder.setCustomContentView(notificationSmallViews)
            builder.setCustomBigContentView(notificationViews)
            builder.setCustomHeadsUpContentView(notificationSmallViews)

//            val avatarUrl = data.getString(CallkitConstants.EXTRA_CALLKIT_AVATAR, "")
//            if (avatarUrl != null && avatarUrl.isNotEmpty()) {
//                val headers =
//                    data.getSerializable(CallkitConstants.EXTRA_CALLKIT_HEADERS) as HashMap<String, Any?>
//                getPicassoInstance(this, headers).load(avatarUrl)
//                    .into(targetLoadAvatarDefault)
//            }
//            notificationBuilder.setContentTitle(
//                data.getString(
//                    CallkitConstants.EXTRA_CALLKIT_NAME_CALLER,
//                    ""
//                )
//            )
//            notificationBuilder.setContentText(
//                data.getString(
//                    CallkitConstants.EXTRA_CALLKIT_HANDLE,
//                    ""
//                )
//            )
//            val textDecline = data.getString(CallkitConstants.EXTRA_CALLKIT_TEXT_DECLINE, "")
//            val declineAction: NotificationCompat.Action = NotificationCompat.Action.Builder(
//                R.drawable.ic_decline,
//                if (TextUtils.isEmpty(textDecline)) this.getString(R.string.text_decline) else textDecline,
//                getDeclinePendingIntent(notificationId, data)
//            ).build()
//            notificationBuilder.addAction(declineAction)
//            val textAccept = data.getString(CallkitConstants.EXTRA_CALLKIT_TEXT_ACCEPT, "")
//            val acceptAction: NotificationCompat.Action = NotificationCompat.Action.Builder(
//                R.drawable.ic_accept,
//                if (TextUtils.isEmpty(textDecline)) this.getString(R.string.text_accept) else textAccept,
//                getAcceptPendingIntent(notificationId, data)
//            ).build()
//            notificationBuilder.addAction(acceptAction)

        with(NotificationManagerCompat.from(this)) {
            notify(2, builder.build())
        }
    }

    private fun initNotificationViews(remoteViews: RemoteViews, id: String, title: String, message: String, s: String) {
        remoteViews.setTextViewText(
            R.id.tvNameCaller,
            title
        )
        val isShowCallID = false
        if (isShowCallID == true) {
            remoteViews.setTextViewText(
                R.id.tvNumber,
                title
            )
        }
        remoteViews.setOnClickPendingIntent(
            R.id.llDecline,
            getDeclinePendingIntent(id)
        )

        remoteViews.setTextViewText(
            R.id.tvDecline,
            "Decline"
        )
        remoteViews.setOnClickPendingIntent(
            R.id.llAccept,
            getAcceptPendingIntent()
        )

        remoteViews.setTextViewText(
            R.id.tvAccept,
            "Accept"
        )
//        val avatarUrl = data.getString(CallkitConstants.EXTRA_CALLKIT_AVATAR, "")
//        if (avatarUrl != null && avatarUrl.isNotEmpty()) {
//            val headers =
//                data.getSerializable(CallkitConstants.EXTRA_CALLKIT_HEADERS) as HashMap<String, Any?>
//            getPicassoInstance(this, headers).load(avatarUrl)
//                .transform(CircleTransform())
//                .into(targetLoadAvatarCustomize)
//        }
    }
    @SuppressLint("SuspiciousIndentation")
    private fun getAcceptPendingIntent(): PendingIntent? {
    val notifyIntent = Intent(this, MainActivity::class.java).apply {
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
    }.apply {
        action = "OPEN_Call_AND_JOIN"


    }
    val notifyPendingIntent = PendingIntent.getActivity(
        this, 0, notifyIntent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

        return notifyPendingIntent

    }
    private fun getDeclinePendingIntent(id: String): PendingIntent? {


        val declineIntent = Intent(this, ButtonReceiver::class.java).apply {
            action = "CLOSE_Call_AND_JOIN"
            putExtra("ID", id)

        }

        val declinePendingIntent = PendingIntent.getBroadcast(
            this, 0, declineIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        return declinePendingIntent
    }
}

data class Notification(
        val id: String,
        val title: String,
        val body: String,
        val icon: String?,
        val url: String?,
        val groupCode: String?,
        val status: Int,
        val dateInsert: String?,
        val sendDate: String?,
        val deliveredCount: Int,
        val clickCount: Int,
        val isActive: Boolean
)

data class CallUser(
        val connectionId: String,
        val userIdHash: String,
        val officeIdHash: String,
        val username: String,
        val inCall: Boolean,
        val isOffice: Boolean,
        val dateUpdate: String
)