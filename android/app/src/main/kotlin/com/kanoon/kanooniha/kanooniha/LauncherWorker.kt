package ir.kanoon.kanooniha.android

import android.content.Context
import android.content.Intent
import androidx.core.content.ContextCompat.startActivity
import androidx.work.Worker
import androidx.work.WorkerParameters
import ir.kanoon.kanooniha.android.MainActivity

class LauncherWorker(private val appContext: Context, workerParams: WorkerParameters) : Worker(appContext, workerParams) {

    override fun doWork(): Result {
        val intent = Intent(appContext, MainActivity::class.java) // Replace with your main activity
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) // Ensure main activity launches in a new task
        appContext.startActivity(intent) // Use the appContext to start the activity
        return Result.success()
    }
}
