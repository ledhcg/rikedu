package com.dinhcuong.mindunlock

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class BootCompleteReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        when (intent?.action) {
            Intent.ACTION_BOOT_COMPLETED -> {
                Log.d("[BootCompleteReceiver]","Boot complete")
                val intentLS = Intent(context, LockScreenService::class.java)
                context?.let {
                    val pref = androidx.preference.PreferenceManager.getDefaultSharedPreferences(context)
                    val useLockScreen = pref.getBoolean("useLockScreen", false)
                    if (useLockScreen){
                        it.startForegroundService(intentLS)
                    }
                }
            }
        }
    }
}