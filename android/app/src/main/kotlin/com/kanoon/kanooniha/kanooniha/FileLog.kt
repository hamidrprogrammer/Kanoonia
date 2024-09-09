package ir.kanoon.kanooniha.android

import android.content.Context
import android.util.Log
import java.io.File
import java.io.FileWriter
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object FileLog {
    private const val LOG_TAG = "FileLog"
    private const val LOG_FILE_NAME = "app_log.txt"
    private var fileWriter: FileWriter? = null
    private var isLogging = false

    fun startLogging(context: Context) {
        try {
//            val logFile = File(context.getExternalFilesDir(null), LOG_FILE_NAME)
//            fileWriter = FileWriter(logFile, true)
//            isLogging = true
            log("Logging started")
        } catch (e: IOException) {
            Log.e(LOG_TAG, "Error opening log file", e)
        }
    }

    fun stopLogging() {
        log("Logging stopped")
        isLogging = false
//        fileWriter?.close()
    }

    fun log(message: String) {
        if (isLogging) {
            val logMessage = "${getCurrentTimeStamp()} $message\n"
            try {
//                fileWriter?.append(logMessage)
//                fileWriter?.flush()
            } catch (e: IOException) {
                Log.e(LOG_TAG, "Error writing log to file", e)
            }
        }
    }

    private fun getCurrentTimeStamp(): String {
        return SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS", Locale.getDefault()).format(Date())
    }

    fun d(tag: String, message: String) {
        Log.d(tag, message)
        log("DEBUG/$tag: $message")
    }

    fun i(tag: String, message: String) {
        Log.i(tag, message)
        log("INFO/$tag: $message")
    }

    fun e(tag: String, message: String) {
        Log.e(tag, message)
        log("ERROR/$tag: $message")
    }
}
