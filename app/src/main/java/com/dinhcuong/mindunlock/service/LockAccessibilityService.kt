package com.dinhcuong.mindunlock.service

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.app.Service
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class LockAccessibilityService: AccessibilityService() {
    val ACTION_LOCK = "com.dinhcuong.mindunlock.service.LOCK"
    override fun onAccessibilityEvent(mAE: AccessibilityEvent?) {
//        val mPN = mAE?.packageName.toString()
//        val mPM = this.packageManager
//        try {
//            val applicationInfo = mPM.getApplicationInfo(mPN, 0)
//            val applicationLabel = mPM.getApplicationLabel(applicationInfo)
//            Log.d("[LockAccessibilityService]", "APP NAME: + ${applicationLabel.toString()}")
//        } catch (e: NumberFormatException){
//            e.printStackTrace()
//        }
    }

    override fun onInterrupt() {
        TODO("Not yet implemented")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if(ACTION_LOCK == intent?.action){
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                performGlobalAction(AccessibilityService.GLOBAL_ACTION_LOCK_SCREEN)
            }
        }
        return Service.START_STICKY;
    }

    override fun onServiceConnected() {
        val info = AccessibilityServiceInfo()
        info.apply {
            eventTypes = AccessibilityEvent.TYPE_VIEW_CLICKED or AccessibilityEvent.TYPE_VIEW_FOCUSED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_SPOKEN
            notificationTimeout = 100
        }

        this.serviceInfo = info

        Log.d("[LockAccessibilityService]", "onServiceConnected")
    }
}