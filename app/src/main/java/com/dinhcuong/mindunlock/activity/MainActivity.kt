package com.dinhcuong.mindunlock.activity

import android.accessibilityservice.AccessibilityServiceInfo
import android.app.AlertDialog
import android.app.KeyguardManager
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.view.accessibility.AccessibilityManager
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.dinhcuong.mindunlock.R
import com.dinhcuong.mindunlock.receiver.AdminReceiver
import com.dinhcuong.mindunlock.service.LockAccessibilityService
import com.dinhcuong.mindunlock.service.LockScreenService
import java.util.function.Consumer


class MainActivity : AppCompatActivity(){
    private var lock: Button? = null
    private var settings: Button? = null
    private var notification: TextView? = null

    private var RESULT_ENABLE = 11
    private val REQUEST_CODE_ENABLE_ADMIN = 1

    private var keyguardManager: KeyguardManager? = null

    private var mCN: ComponentName? = null
    private var mDPM : DevicePolicyManager? = null
    private var mAM: AccessibilityManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
//        val intent = Intent(this, ScreenOnOffService::class.java)
//        startService(intent)
//        window.addFlags(
//            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
//                    WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD or
//                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
//                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
//        )
//        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
//        window.statusBarColor = Color.TRANSPARENT
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        mAM = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
        mDPM  = getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
        mCN = ComponentName(this, AdminReceiver::class.java)
        


        settings = findViewById(R.id.settings)
        lock = findViewById(R.id.lock)
        notification = findViewById(R.id.notification)

        keyguardManager = applicationContext.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
        if(keyguardManager!!.isDeviceSecure()){
            notification!!.text = "The device is secured with a PIN, pattern or password."
        } else {
            notification!!.text = "The device is not secured."
        }




        lock!!.setOnClickListener {
//            val active = mDPM !!.isAdminActive(mCN!!)
//            if (active) {
//                mDPM !!.lockNow()
//            } else {
//                Toast.makeText(
//                    this,
//                    "You need to enable the Admin Device Features",
//                    Toast.LENGTH_SHORT
//                ).show()
//            }

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                if (isAccessibilityServiceEnabled()) {
                    startLockAccessibilityService();
                    finish();
                } else {
                    enableAppAsAccessibilityService();
                }
            } else if (isAdminActive()) {
                lockAsDeviceAdmin();
                finish();
            } else {
                enableAppAsAdministrator();
            }
        }
        settings!!.setOnClickListener {
            val intentSettings = Intent(this, SettingsActivity::class.java)
            startActivity(intentSettings)
        }


        if (isDeviceSecure(applicationContext)){
            Log.d("[MainActivity]", "LS-enable")
        }
    }

    fun isDeviceSecure(context: Context): Boolean{
        val manager = context.getSystemService(KEYGUARD_SERVICE) as KeyguardManager
        return manager.isDeviceSecure
    }


    private fun isAdminActive(): Boolean {
        return mDPM!!.isAdminActive(mCN!!)
    }

    private fun lockAsDeviceAdmin() {
        mDPM!!.lockNow()
    }
    private fun checkPermission() {
        if (!Settings.canDrawOverlays(this)) {
            val uri = Uri.fromParts("package", packageName, null)
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, uri)
            startActivityForResult(intent, 0)
        } else {
            val intent = Intent(applicationContext, LockScreenService::class.java)
            startForegroundService(intent)
        }
    }

    private fun enableAppAsAdministrator() {
        val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
        startActivityForResult(intent, REQUEST_CODE_ENABLE_ADMIN)
    }

    private fun enableAppAsAccessibilityService() {
        AlertDialog.Builder(this)
            .setMessage("Enable Accessibility Service")
            .setPositiveButton(android.R.string.ok) { _, _ ->
                val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                startActivity(intent)
            }
            .setNegativeButton(android.R.string.cancel) { dialog, _ -> dialog.dismiss() }
            .show()
        Log.d("[MainActivity]", "enableAppAsAccessibilityService")
    }

    @Deprecated("Deprecated in Java")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        when (requestCode) {
            RESULT_ENABLE -> if (resultCode == RESULT_OK) {
                Toast.makeText(
                    this@MainActivity,
                    "You have enabled the Admin Device features",
                    Toast.LENGTH_SHORT
                ).show()
            } else {
                Toast.makeText(
                    this@MainActivity,
                    "Problem to enable the Admin Device features",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }

        super.onActivityResult(requestCode, resultCode, data)
    }

    override fun onResume() {
        super.onResume()
        if(keyguardManager!!.isDeviceSecure()){
            notification!!.text = "The device is secured with a PIN, pattern or password."
        } else {
            notification!!.text = "The device is not secured."
        }
    }

    private fun startLockAccessibilityService() {
        val intent = Intent(
            LockAccessibilityService().ACTION_LOCK, null, this,
            LockAccessibilityService::class.java
        )
        Log.d("[MainActivity]", "startLockAccessibilityService")
        startService(intent)

    }

    private fun isAccessibilityServiceEnabled(): Boolean {
        val enabled = booleanArrayOf(false)
        mAM!!.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK)
            .forEach(
                Consumer { enabledAccessibilityService: AccessibilityServiceInfo ->
                    val enabledServiceInfo: ServiceInfo =
                        enabledAccessibilityService.resolveInfo.serviceInfo
                    if (enabledServiceInfo.packageName.equals(packageName) && enabledServiceInfo.name.equals(
                            LockAccessibilityService::class.java.name
                        )
                    ) {
                        enabled[0] = true
                    }
                })
        return enabled[0]
    }
}