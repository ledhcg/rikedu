package com.dinhcuong.mindunlock.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.PowerManager
import android.util.Log
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity

class LockScreenActivity : AppCompatActivity() {
    private var webView: WebView? = null
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        webView = WebView(applicationContext)
        setContentView(webView)
        webView!!.webViewClient = WebViewClient()
        webView!!.addJavascriptInterface(WebAppInterface(this), "Android")
        webView!!.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowContentAccess = true
        }
        webView!!.loadUrl("file:///android_asset/index.html")
    }

    class WebAppInterface(private val context: Context) {
        @JavascriptInterface
        fun showToast(toast: String) {
            Toast.makeText(context, toast, Toast.LENGTH_SHORT).show()
            Log.d("[JavascriptInterface]", "showToast")
        }

        @JavascriptInterface
        fun unlockAndroid() {
            Toast.makeText(context, "Unlocked-LS", Toast.LENGTH_SHORT).show()
            Log.d("[JavascriptInterface]", "unlockAndroid")
        }
    }
}