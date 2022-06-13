package com.dinhcuong.mindunlock.activity

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat.getSystemService
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
        override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
            setPreferencesFromResource(R.xml.root_preferences, rootKey)
            val useLockScreenPref = findPreference<SwitchPreferenceCompat>("useLockScreen")
            val screenTimeout = findPreference<ListPreference>("time")

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

            if (useLockScreenPref.isChecked){
                Log.d("[SettingsFragment]","startForegroundService")
                activity?.startForegroundService(intent)
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

    }

}