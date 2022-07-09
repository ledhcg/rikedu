package com.dinhcuong.mindunlock.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import android.widget.Toast
import com.dinhcuong.mindunlock.activity.LockScreenActivity
import com.dinhcuong.mindunlock.service.LockScreenService

class BootCompleteReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        when (intent?.action) {
            Intent.ACTION_BOOT_COMPLETED -> {
                Log.d("[BootCompleteReceiver]","Boot complete")
                Toast.makeText(
                    context,
                    "Startup",
                    Toast.LENGTH_SHORT
                ).show()

                val intentLockScreen = Intent(context, LockScreenActivity::class.java)
                intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                context?.startActivity(intentLockScreen)
                val intentLS = Intent(context, LockScreenService::class.java)
                context?.let {
                    val pref = androidx.preference.PreferenceManager.getDefaultSharedPreferences(context)
                    val useLockScreen = pref.getBoolean("useLockScreen", false)
                    if (useLockScreen){
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                            it.startForegroundService(intentLS)
                        } else {
                            it.startService(intentLS)
                        }
                    }
                }
            }
        }
    }
}