package ir.kanoon.kanooniha.android

import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Bundle
import ir.kanoon.kanooniha.android.MainActivity

class LauncherActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val taskManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val topTask = taskManager.getRunningTasks(1).firstOrNull()

        if (topTask?.topActivity?.className?.contains("your.package.name.MainActivity") == true) {
            finish()
        } else {
            val intent = Intent(this, MainActivity::class.java) // Replace with your main activity
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK) // Ensure main activity launches in a new task
            startActivity(intent)
            finish()
        }
    }
}