package com.dinhcuong.mindunlock

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity


class MainActivity : AppCompatActivity(){
    private var lock: Button? = null
    private var settings: Button? = null
    private var disable:Button? = null
    private var enable:Button? = null
    private val RESULT_ENABLE = 11
    private var devicePolicyManager: DevicePolicyManager? = null
    private var compName: ComponentName? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        val intent = Intent(this, ScreenOnOffService::class.java)
        startService(intent)
        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD or
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )



        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)
        checkPermission()

        devicePolicyManager = getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
        compName = ComponentName(this, AdminController::class.java)

        settings = findViewById(R.id.settings)
        lock = findViewById(R.id.lock)
        enable = findViewById(R.id.enableBtn)
        disable = findViewById(R.id.disableBtn)

        enable!!.setOnClickListener {
            val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, compName)
            intent.putExtra(
                DevicePolicyManager.EXTRA_ADD_EXPLANATION,
                "Additional text explaining why we need this permission"
            )
            startActivityForResult(intent, RESULT_ENABLE)
        }

        disable!!.setOnClickListener {
            devicePolicyManager!!.removeActiveAdmin(compName!!)
            disable!!.visibility = View.GONE
            enable!!.visibility = View.VISIBLE
        }

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
            val intent = Intent(this, SettingsActivity::class.java)
            startActivity(intent)
        }
    }

    override fun onResume() {
        super.onResume()
        val isActive = devicePolicyManager!!.isAdminActive(compName!!)
        disable!!.visibility = if (isActive) View.VISIBLE else View.GONE
        enable!!.visibility = if (isActive) View.GONE else View.VISIBLE
//        val intent = Intent(this, ScreenOnOffService::class.java)
//        startService(intent)
    }

    override fun onPause() {
        super.onPause()
//        val intent = Intent(this, ScreenOnOffService::class.java)
//        startService(intent)
    }


//    override fun onDestroy() {
//        super.onDestroy()
////        val intent = Intent(this, ScreenOnOffService::class.java)
////        startService(intent)
//    }

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

    fun lockScreen(){
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
//    override fun onClick(view: View?) {
//        if (view === lock) {
//            val active = devicePolicyManager!!.isAdminActive(compName!!)
//            if (active) {
//                devicePolicyManager!!.lockNow()
//            } else {
//                Toast.makeText(
//                    this,
//                    "You need to enable the Admin Device Features",
//                    Toast.LENGTH_SHORT
//                ).show()
//            }
//        } else if (view === enable) {
//            val intent = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
//            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, compName)
//            intent.putExtra(
//                DevicePolicyManager.EXTRA_ADD_EXPLANATION,
//                "Additional text explaining why we need this permission"
//            )
//            startActivityForResult(intent, RESULT_ENABLE)
//        } else if (view === disable) {
//            devicePolicyManager!!.removeActiveAdmin(compName!!)
//            disable!!.visibility = View.GONE
//            enable!!.visibility = View.VISIBLE
//        }
//    }

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

    override fun setShowWhenLocked(showWhenLocked: Boolean) {
        super.setShowWhenLocked(showWhenLocked)
//        Log.d("LockScreen", "LockScreen")
//        val intent = Intent(applicationContext, LockScreenActivity::class.java)
//        startActivity(intent)

    }

}