package com.dinhcuong.mindunlock

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.preference.PreferenceFragmentCompat
import androidx.preference.SwitchPreferenceCompat

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
        override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
            setPreferencesFromResource(R.xml.root_preferences, rootKey)
            val useLockScreenPref = findPreference<SwitchPreferenceCompat>("useLockScreen")
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
    }
}