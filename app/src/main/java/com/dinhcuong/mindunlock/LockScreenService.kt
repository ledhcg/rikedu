package com.dinhcuong.mindunlock

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Color
import android.os.Build
import android.os.IBinder
import android.util.Log

class LockScreenService: Service() {

    var receiver: ScreenOnOffReceiver? = null
    private val ANDROID_CHANNEL_ID = "com.dinhcuong.mindunlock"
    private val NOTIFICATION_ID = 1999


    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        super.onCreate()
        Log.d("[LockScreenService]", "onCreate")
        if(receiver == null){
            receiver = ScreenOnOffReceiver()
            val filter = IntentFilter(Intent.ACTION_SCREEN_OFF)
            registerReceiver(receiver, filter)
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)
        if(intent != null
            && intent.action == null
            && receiver == null){
            receiver = ScreenOnOffReceiver()
            val filter = IntentFilter(Intent.ACTION_SCREEN_OFF)
            registerReceiver(receiver, filter)
        }
        Log.d("[LockScreenService]", "onStartCommand")

        val chan = NotificationChannel(ANDROID_CHANNEL_ID,"AppService", NotificationManager.IMPORTANCE_NONE)
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE

        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(chan)

        val builder = Notification.Builder(this, ANDROID_CHANNEL_ID)
            .setContentTitle(getString(R.string.app_name))
            .setContentText("SmartTracker Running")
        val notification = builder.build()

        startForeground(NOTIFICATION_ID, notification)

        return START_REDELIVER_INTENT
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("[LockScreenService]", "onDestroy")
        if (receiver != null){
            unregisterReceiver(receiver)
        }
    }
}