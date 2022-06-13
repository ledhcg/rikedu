package com.dinhcuong.mindunlock.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.dinhcuong.mindunlock.activity.LockScreenActivity

class ScreenOnOffReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        when (intent?.action) {
            Intent.ACTION_SCREEN_OFF -> {
                Log.d("ScreenOnOffReceiver", "Screen Off")
                Log.d("ScreenOnOffReceiver","$context")
                val intentLockScreen = Intent(context, LockScreenActivity::class.java)
                intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                context?.startActivity(intentLockScreen)
            }
            Intent.ACTION_SCREEN_ON -> {
                Log.d("ScreenOnOffReceiver", "Screen On")
            }
        }
    }
}