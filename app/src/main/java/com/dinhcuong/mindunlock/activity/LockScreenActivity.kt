package com.dinhcuong.mindunlock.activity

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.webkit.JavascriptInterface
import android.webkit.WebView
import android.webkit.WebViewClient
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat.startActivity

class LockScreenActivity : AppCompatActivity() {
    private var webView: WebView? = null
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        webView = WebView(applicationContext)
        setContentView(webView)
        webView!!.webViewClient = LockScreenWebView()
        webView!!.addJavascriptInterface(WebAppInterface(this), "Android")
        webView!!.settings.apply {
            javaScriptEnabled = true
            domStorageEnabled = true
            allowContentAccess = true
        }
        webView!!.loadUrl("https://zergity.github.io/mind-unlock/")
//        webView!!.loadUrl("file:///android_asset/index.html")

    }

    class WebAppInterface(private val context: Context) {
        @JavascriptInterface
        fun showToast(toast: String) {
            Toast.makeText(context, toast, Toast.LENGTH_SHORT).show()
            Log.d("[JavascriptInterface]", "showToast")
        }

        @JavascriptInterface
        fun unlockAndroid() {
            Toast.makeText(context, "Unlocked", Toast.LENGTH_SHORT).show()
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
                "javascript:(function() {document.body.style.paddingTop = '50px'; var btn = document.getElementById('btn-unlock');btn.setAttribute('onclick', 'Android.unlockAndroid()')})()"
            )
        }
    }
}