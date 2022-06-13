package com.dinhcuong.mindunlock.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.webkit.JavascriptInterface
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.dinhcuong.mindunlock.R

class LockScreenActivity : AppCompatActivity() {

    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val webView = WebView(applicationContext)
        setContentView(webView)
        webView.webViewClient = WebViewClient()
        webView.addJavascriptInterface(WebAppInterface(this), "Android")
        webView.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowContentAccess = true
        }
        webView.loadUrl("file:///android_asset/index.html")
    }

    class WebAppInterface(private val context: Context) {
        @JavascriptInterface
        fun showToast(toast: String) {
            Toast.makeText(context, toast, Toast.LENGTH_SHORT).show()
        }

        @JavascriptInterface
        fun unlockAndroid() {
            Toast.makeText(context, "Unlocked", Toast.LENGTH_SHORT).show()
            val intentLockScreen = Intent(context, MainActivity::class.java)
            intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intentLockScreen.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            context.startActivity(intentLockScreen)
        }
    }
}