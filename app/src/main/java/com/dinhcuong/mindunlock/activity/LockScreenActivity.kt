package com.dinhcuong.mindunlock.activity

import android.annotation.SuppressLint
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.WindowManager
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.FragmentActivity
import androidx.preference.PreferenceManager
import com.dinhcuong.mindunlock.receiver.AdminReceiver
import com.dinhcuong.mindunlock.utils.SharedPref
import java.util.*
import kotlin.concurrent.schedule


class LockScreenActivity : AppCompatActivity() {
    private var sharedPref: SharedPref? = null

    private var webView: WebView? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedPref = SharedPref(this)


        webView = WebView(applicationContext)
        setContentView(webView)
        webView!!.webViewClient = LockScreenWebView()
        webView!!.addJavascriptInterface(WebAppInterface(this, sharedPref!!, webView!!), "webview")

        webView!!.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowContentAccess = true
        }
        webView!!.loadUrl("https://zergity.github.io/mind-unlock/")
//        webView!!.loadUrl("file:///android_asset/index.html")


    }


    //To prevent user from exiting (without properly unlocking) this activity, when it loses focus the screen locks again
    override fun onStop() {
        super.onStop()
        if (sharedPref!!.getIsLocking()){
            Log.d("[JavascriptInterface]", "getIsLockScreenRunning - true")
//            val devicePolicyManager = getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
//            devicePolicyManager.lockNow()
            val intentLockScreen = Intent(applicationContext, LockScreenActivity::class.java)
            intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            applicationContext?.startActivity(intentLockScreen)
        } else {
            Log.d("[JavascriptInterface]", "getIsLockScreenRunning - false")
        }
    }

    //Does nothing on back press
    override fun onBackPressed() {}

    class WebAppInterface(private val context: Context, sharedPref: SharedPref, webView: WebView) {
        private var sp = sharedPref
        private var wV = webView
        @JavascriptInterface
        fun showToast(toast: String) {
            Toast.makeText(context, toast, Toast.LENGTH_SHORT).show()
            Log.d("[JavascriptInterface]", "showToast")
        }

        @JavascriptInterface
        fun receiveMessage(data: String?): Boolean {
            Log.d("[JavascriptInterface]", "receiveMessage")
            Log.d("[JavascriptInterface]", data.toString())
            Toast.makeText(context, data, Toast.LENGTH_SHORT).show()

            sp.setIsLocking(false)
//            reload()
            unlockAndroid()
//            reload()
            return false // here we return true if we handled the post.
        }

        @JavascriptInterface
        fun unlockAndroid() {
//            Toast.makeText(context, "Unlocked", Toast.LENGTH_SHORT).show()
            //HomeScreen

            setTimeoutToLock()
            backHomeApp()
            val homeIntent = Intent(Intent.ACTION_MAIN)
            homeIntent.addCategory(Intent.CATEGORY_HOME)
            homeIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            context.startActivity(homeIntent)
        }


        private fun backHomeApp() {
            val intentHomeApp = Intent(context, MainActivity::class.java)
            intentHomeApp.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intentHomeApp.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            context.startActivity(intentHomeApp)
        }

        //Set the device usage time after unlocking the device
        private fun setTimeoutToLock(){
            val pref: SharedPreferences = PreferenceManager.getDefaultSharedPreferences(context)
            val timeout = pref.getString("time", "0")
            Log.d("[LockScreenActivity]", "Timeout: $timeout")
            if(timeout.toString().toLong() != 0.toLong()){
                val timeMs: Long = 1000L * timeout.toString().toLong()
                Handler().postDelayed({
                    Toast.makeText(context, "The device will lock in 10 seconds", Toast.LENGTH_SHORT).show()
                    Handler().postDelayed({
                        val mDPM = context.getSystemService(DEVICE_POLICY_SERVICE) as DevicePolicyManager
                        val mCN = ComponentName(context, AdminReceiver::class.java)
                        if(mDPM.isAdminActive(mCN)) mDPM.lockNow()
                    }, 10000)
                }, timeMs-10000)
            }
        }

    }

    class LockScreenWebView: WebViewClient(){
        override fun onPageFinished(webView: WebView?, url: String?) {
            super.onPageFinished(webView, url)
            webView?.loadUrl(
                "javascript:(function() {document.body.style.paddingTop = '50px'})();"
            )
        }
    }
}