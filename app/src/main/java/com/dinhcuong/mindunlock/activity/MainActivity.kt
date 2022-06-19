package com.dinhcuong.mindunlock.activity

import android.app.KeyguardManager
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SwitchCompat
import com.dinhcuong.mindunlock.R
import com.dinhcuong.mindunlock.receiver.AdminReceiver
import com.dinhcuong.mindunlock.service.LockScreenService
import com.dinhcuong.mindunlock.utils.SharedPref


class MainActivity : AppCompatActivity(){
    private var lock: Button? = null
    private var settings: Button? = null
    private var startSwitch: SwitchCompat? = null



    private var RESULT_ENABLE = 11

    private var devicePolicyManager: DevicePolicyManager? = null
    private var compName: ComponentName? = null

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


        devicePolicyManager = getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
        compName = ComponentName(this, AdminReceiver::class.java)

        settings = findViewById(R.id.settings)
        lock = findViewById(R.id.lock)
        startSwitch = findViewById(R.id.start_switch)




        lock!!.setOnClickListener {
            val active = devicePolicyManager!!.isAdminActive(compName!!)
            if (active) {
                devicePolicyManager!!.lockNow()
            } else {
                Toast.makeText(
                    this,
                    "You need to enable the Admin Device Features",
                    Toast.LENGTH_SHORT
                ).show()
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


}