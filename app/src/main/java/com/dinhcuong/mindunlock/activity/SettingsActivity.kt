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



        override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
            setPreferencesFromResource(R.xml.root_preferences, rootKey)
            val useLockScreenPref = findPreference<SwitchPreferenceCompat>("useLockScreen")
            val screenTimeout = findPreference<ListPreference>("time")
            prefDrawOverOtherApps = findPreference("pref_draw_over_other_apps")
            prefAdmin = findPreference("pref_admin")

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

            val intent = Intent(activity, LockScreenService::class.java)
            useLockScreenPref!!.setOnPreferenceClickListener {
                when {
                    useLockScreenPref.isChecked -> {
                        Log.d("[SettingsFragment]","startForegroundService")
                        activity?.startForegroundService(intent)
                    }
                    else -> activity?.stopService(intent)
                }
                true
            }

            prefAdmin!!.setOnPreferenceClickListener {
                handlePermissionDevice(prefAdmin!!)
                true
            }

            prefDrawOverOtherApps!!.setOnPreferenceClickListener {
                handlePermissionDOOA(prefDrawOverOtherApps!!)
                true
            }

            if (useLockScreenPref.isChecked){
                Log.d("[SettingsFragment]","startForegroundService")
                activity?.startForegroundService(intent)
            }
        }


        private fun handlePermissionDOOA(prefDrawOverOtherApps : SwitchPreferenceCompat){
            val context: FragmentActivity? = activity
            when {
                prefDrawOverOtherApps.isChecked -> {
                    val uri = Uri.fromParts("package", activity?.packageName, null)
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
                        "Additional text explaining why we need this permission"
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


            val intentLS = Intent(context, LockScreenService::class.java)
            devicePolicyManager = context?.getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
            compName = ComponentName(requireContext(), AdminReceiver::class.java)

            if (Settings.canDrawOverlays(activity)) {
                prefDrawOverOtherApps?.isChecked = true
                context?.startForegroundService(intentLS)
            } else {
                prefDrawOverOtherApps?.isChecked = false
                context?.stopService(intentLS)
            }
            prefAdmin?.isChecked = devicePolicyManager!!.isAdminActive(compName!!)
        }

    }

}