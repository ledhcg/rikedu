package com.dinhcuong.mindunlock.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.dinhcuong.mindunlock.utils.SharedPref


class LockScreenActivity : AppCompatActivity() {
    private var sharedPref: SharedPref? = null

    private var webView: WebView? = null

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        window.addFlags(
            WindowManager.LayoutParams.FLAG_FULLSCREEN
        )
        super.onCreate(savedInstanceState)
        sharedPref = SharedPref(this)


        webView = WebView(applicationContext)
        setContentView(webView)
        webView!!.webViewClient = LockScreenWebView()
        webView!!.addJavascriptInterface(WebAppInterface(this, sharedPref!!), "webview")

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

    class WebAppInterface(private val context: Context, sharedPref: SharedPref) {
        private var sp = sharedPref
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
            unlockAndroid()
//            LockScreenActivity().unlockAndFinish()
            return false // here we return true if we handled the post.
        }

        @JavascriptInterface
        fun unlockAndroid() {
//            Toast.makeText(context, "Unlocked", Toast.LENGTH_SHORT).show()
            //HomeScreen

            val homeIntent = Intent(Intent.ACTION_MAIN)
            homeIntent.addCategory(Intent.CATEGORY_HOME)
            homeIntent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
            context.startActivity(homeIntent)
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