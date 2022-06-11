package com.dinhcuong.mindunlock

import android.app.Service
import android.content.Intent
import android.content.IntentFilter
import android.os.IBinder


class ScreenOnOffService: Service() {
    private var screenReceiver: ScreenOnOffReceiver? = null
    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        registerScreenStatusReceiver()
    }

    override fun onDestroy() {
        unregisterScreenStatusReceiver()
    }

    private fun registerScreenStatusReceiver() {
        screenReceiver = ScreenOnOffReceiver()
        val filter = IntentFilter()
        filter.addAction(Intent.ACTION_SCREEN_OFF)
        filter.addAction(Intent.ACTION_SCREEN_ON)
        registerReceiver(screenReceiver, filter)
    }

    private fun unregisterScreenStatusReceiver() {
        try {
            if (screenReceiver != null) {
                unregisterReceiver(screenReceiver)
            }
        } catch (e: IllegalArgumentException) {
        }
    }
}