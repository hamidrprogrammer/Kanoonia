package ir.kanoon.kanooniha.android

import android.content.Context
import android.content.SharedPreferences
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class SharedPreferencesHelper(context: Context) {
    private val sharedPreferences: SharedPreferences =
        context.getSharedPreferences("MySharedPrefs", Context.MODE_PRIVATE)

    suspend fun saveString(key: String, value: String) {
        withContext(Dispatchers.IO) {
            sharedPreferences.edit().putString(key, value).apply()
        }
    }

    suspend fun getString(key: String): String? {
        return withContext(Dispatchers.IO) {
            sharedPreferences.getString(key, null)
        }
    }

    suspend fun deleteString(key: String) {
        withContext(Dispatchers.IO) {
            sharedPreferences.edit().remove(key).apply()
        }
    }

    // Add more functions as needed for other data types (e.g., Int, Boolean, etc.)
}
