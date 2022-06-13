package com.dinhcuong.mindunlock.activity

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.webkit.ServiceWorkerWebSettings
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat.startForegroundService
import androidx.fragment.app.FragmentActivity
import androidx.preference.ListPreference
import androidx.preference.PreferenceFragmentCompat
import androidx.preference.PreferenceManager
import androidx.preference.SwitchPreferenceCompat
import com.dinhcuong.mindunlock.R
import com.dinhcuong.mindunlock.receiver.AdminReceiver
import com.dinhcuong.mindunlock.service.LockScreenService


class SettingsActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.settings_activity)
        if (savedInstanceState == null) {
            supportFragmentManager
                .beginTransaction()
                .replace(R.id.settings, SettingsFragment())
                .commit()
        }
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
    }

    class SettingsFragment : PreferenceFragmentCompat() {
        private var devicePolicyManager: DevicePolicyManager? = null
        private var compName: ComponentName? = null
        private var RESULT_ENABLE = 11

        private var prefDrawOverOtherApps: SwitchPreferenceCompat? = null
        private var prefAdmin: SwitchPreferenceCompat? = null
        private var useLockScreenPref: SwitchPreferenceCompat? = null
        private var screenTimeout: ListPreference? = null

        private var intentLS: Intent? = null



        override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
            setPreferencesFromResource(R.xml.root_preferences, rootKey)

            useLockScreenPref = findPreference("useLockScreen")
            screenTimeout = findPreference<ListPreference>("time")
            prefDrawOverOtherApps = findPreference("pref_draw_over_other_apps")
            prefAdmin = findPreference("pref_admin")

            intentLS = Intent(activity, LockScreenService::class.java)

            useLockScreenPref!!.setOnPreferenceClickListener {

                when {
                    useLockScreenPref!!.isChecked -> {
                        if (prefAdmin!!.isChecked && prefDrawOverOtherApps!!.isChecked){
                            Log.d("[SettingsFragment]","startForegroundService")
                            activity?.startForegroundService(intentLS)
                        } else {
                            useLockScreenPref!!.isChecked = false
                            Toast.makeText(
                                activity,
                                "You need permission to perform this action",
                                Toast.LENGTH_SHORT
                            ).show()
                        }
                    }
                    else -> {
                        Log.d("[SettingsFragment]","stopService")
                        activity?.stopService(intentLS)
                    }
                }
                prefAdmin!!.isChecked && prefDrawOverOtherApps!!.isChecked
            }

            prefDrawOverOtherApps!!.setOnPreferenceClickListener {
                handlePermissionDOOA(prefDrawOverOtherApps!!)
                true
            }

            screenTimeout!!.setOnPreferenceChangeListener { preference, newValue ->
                if(preference is ListPreference){
                    val index = preference.findIndexOfValue(newValue.toString())
                    val entry = preference.entries[index]
                    val entryValue = preference.entryValues[index]
                    val time = entryValue.toString().toLong()
                    setTimeoutToLock(time)
                    Log.i("[SettingFragment]", "Position: $index | Value: $entry | Entryvalue: $entryValue")
                }
                true
            }

            prefAdmin!!.setOnPreferenceClickListener {
                handlePermissionDevice(prefAdmin!!)
                true
            }



//            if (useLockScreenPref!!.isChecked){
//                Log.d("[SettingsFragment]","startForegroundService")
//                activity?.startForegroundService(intentLS)
//            }
        }


        private fun handlePermissionDOOA(prefDrawOverOtherApps : SwitchPreferenceCompat){
            val context: FragmentActivity? = activity
            when {
                prefDrawOverOtherApps.isChecked -> {
                    val uri = Uri.fromParts("package", context!!.packageName, null)
                    val intentMOP = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, uri)
                    startActivityForResult(intentMOP, 0)
                }
            }
        }

        private fun handlePermissionDevice(prefAdmin: SwitchPreferenceCompat){
            val context: FragmentActivity? = activity
            devicePolicyManager = context!!.getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
            compName = ComponentName(context, AdminReceiver::class.java)
            when{
                prefAdmin.isChecked -> {
                    val intentDPM = Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN)
                    intentDPM.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, compName)
                    intentDPM.putExtra(
                        DevicePolicyManager.EXTRA_ADD_EXPLANATION,
                        "We need this permission to perform the lock screen function."
                    )
                    startActivityForResult(intentDPM, RESULT_ENABLE)
                } else -> devicePolicyManager!!.removeActiveAdmin(compName!!)
            }
        }


        private fun setTimeoutToLock(time: Long){
            val context: FragmentActivity? = activity
            val pref: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(context!!)
            val timeout = pref.getString("time", "0")
            Log.d("[SettingsActivity]", "Timeout: $timeout")

            devicePolicyManager = context.getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
            compName = ComponentName(context, AdminReceiver::class.java)

            if(time != 0.toLong()){
                val active = devicePolicyManager!!.isAdminActive(compName!!)
                if (active) {
                    val timeMs: Long = 1000L * time //.text.toString().toLong()
                    Log.d("[SettingsActivity]", "Timeout: $timeMs")
                    Toast.makeText(
                        context,
                        "Timeout: $timeMs",
                        Toast.LENGTH_SHORT
                    ).show()
                    devicePolicyManager!!.setMaximumTimeToLock(compName!!, timeMs)
                }
            }
        }

        override fun onResume() {
            super.onResume()

            devicePolicyManager = context?.getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
            compName = ComponentName(requireContext(), AdminReceiver::class.java)

            prefDrawOverOtherApps?.isChecked = Settings.canDrawOverlays(activity)

//            if (Settings.canDrawOverlays(activity)) {
//                prefDrawOverOtherApps?.isChecked = true
////                context?.startForegroundService(intentLS)
//            } else {
//                prefDrawOverOtherApps?.isChecked = false
////                context?.stopService(intentLS)
//            }
            prefAdmin?.isChecked = devicePolicyManager!!.isAdminActive(compName!!)
        }

    }

}