package com.dinhcuong.mindunlock.service

import android.app.*
import android.content.*
import android.graphics.Color
import android.os.IBinder
import android.util.Log
import com.dinhcuong.mindunlock.R
import com.dinhcuong.mindunlock.receiver.ScreenOnOffReceiver

class LockScreenService: Service() {

    var receiver: ScreenOnOffReceiver? = null
    private val ANDROID_CHANNEL_ID = "com.dinhcuong.mindunlock"
    private val NOTIFICATION_ID = 1999


    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        super.onCreate()
        Log.d("[LockScreenService]", "onCreate")
        if(receiver == null){
            receiver = ScreenOnOffReceiver()
            val filter = IntentFilter(Intent.ACTION_SCREEN_OFF)
            registerReceiver(receiver, filter)
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)
        if(intent != null
            && intent.action == null
            && receiver == null){
            receiver = ScreenOnOffReceiver()
            val filter = IntentFilter(Intent.ACTION_SCREEN_OFF)
            registerReceiver(receiver, filter)
        }
        Log.d("[LockScreenService]", "onStartCommand")

        val chan = NotificationChannel(ANDROID_CHANNEL_ID,"AppService", NotificationManager.IMPORTANCE_NONE)
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE

        val manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(chan)

        val builder = Notification.Builder(this, ANDROID_CHANNEL_ID)
            .setContentTitle(getString(R.string.app_name))
            .setContentText("SmartTracker Running")
        val notification = builder.build()

        startForeground(NOTIFICATION_ID, notification)

        return START_REDELIVER_INTENT
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d("[LockScreenService]", "onDestroy")
        if (receiver != null){
            unregisterReceiver(receiver)
        }
    }
//    private var listenerNotes: OnSharedPreferenceChangeListener? = null
//    private var sp: SharedPref? = null
//    private val cp: CheckPermissions = CheckPermissions()
//
//    private val mReceiver: BroadcastReceiver = object : BroadcastReceiver() {
//        override fun onReceive(context: Context, intent: Intent) {
//            if (intent.action == Intent.ACTION_SCREEN_OFF || intent.action == "changeNotificationColor") startLockForeground()
//            if (intent.action == Intent.ACTION_USER_PRESENT) startLockScreenActivity()
//        }
//    }
//
//    override fun onBind(intent: Intent?): IBinder? {
//        return null
//    }
//
//    override fun onCreate() {
//        sp = SharedPref(this)
//    }
//
//    //Registers the receiver for lockscreen events
//    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
//        val filter = IntentFilter()
//        filter.addAction(Intent.ACTION_SCREEN_OFF)
//        filter.addAction(Intent.ACTION_USER_PRESENT)
//        filter.addAction(Intent.ACTION_HEADSET_PLUG)
//        filter.addAction(Intent.ACTION_REBOOT)
//        filter.addAction(Intent.ACTION_SHUTDOWN)
//        //Used to change color of the notification, green when screen is unlocked, red when is locked
//        filter.addAction("changeNotificationColor")
//        //Used instead of "changeNotificationColor" to set previousVolume avoiding increasing volume while LockScreenActivity finishes
//        filter.addAction("finishedLockScreenActivity")
//        //Used to prevent Ear Training activities from starting when a parsing error occurs
//        filter.addAction("parsingError")
//        registerReceiver(mReceiver, filter)
//        if (cp.checkPermissions(this) && sp!!.getSharedmPrefService()) {
//            startLockForeground()
//            listenerNotes =
//                OnSharedPreferenceChangeListener { prefs: SharedPreferences, key: String? -> if ((prefs == sp!!.getmPrefNotes())) startLockForeground() }
//            sp!!.getmPrefNotes()!!.registerOnSharedPreferenceChangeListener(listenerNotes)
//        } else stopSelf()
//        return START_NOT_STICKY
//    }
//
//    //Unregisters the receiver
//    override fun onDestroy() {
//        super.onDestroy()
//        unregisterReceiver(mReceiver)
//
//        //Updates the tile
//        TileService.requestListeningState(this, ComponentName(this, LockTileService::class.java))
//    }
//
//    private fun startLockScreenActivity() {
//        startActivity(
//            Intent(this, LockScreenActivity::class.java)
//                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//        )
//    }
//
//    //Foreground service (with pending intent):
//    //Since android 10 (maybe before?) after 20 seconds services go in background. Solved using accessibility service
//    private fun startLockForeground() {
//        if (sp!!.getSharedmPrefFirstRunAccessibilitySettings()) sp!!.setSharedmPrefFirstRunAccessibilitySettings(
//            false
//        )
//        val chan = NotificationChannel(
//            getString(R.string.app_name),
//            getString(R.string.app_name),
//            NotificationManager.IMPORTANCE_HIGH
//        )
//        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
//        (getSystemService(NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(
//            chan
//        )
//        val notificationIntent = Intent(this, MainActivity::class.java)
//            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//        val pendingIntent = PendingIntent
//            .getActivity(this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)
//        val broadcastIntent = Intent(this, IncrementNumberOfNotes::class.java)
//        val actionIncrementNotes = PendingIntent
//            .getService(this, 0, broadcastIntent, PendingIntent.FLAG_IMMUTABLE)
//        val increaseNotes = NotificationCompat.Action.Builder(
//            0, getString(R.string.notes_increase), actionIncrementNotes
//        ).build()
//        val notificationBuilder = NotificationCompat.Builder(this, getString(R.string.app_name))
//        if (!CheckPermissions().getIsScreenLocked(this)) {
//            //Notification panel when the screen is unlocked
//            //Green
//            val notification: Notification = notificationBuilder
//                .setOngoing(true)
//                .setOnlyAlertOnce(true)
//                .setChannelId(getString(R.string.app_name))
//                .setSmallIcon(R.drawable.ic_launcher_foreground)
//                .setColor(Color.GREEN)
//                .setContentTitle(getString(R.string.number_of_notes_to_play) + ": " + sp!!.getSharedmPrefNumberOfNotesToPlay())
//                .setPriority(NotificationManager.IMPORTANCE_HIGH)
//                .setCategory(Notification.CATEGORY_SERVICE)
//                .setContentIntent(pendingIntent)
//                .addAction(increaseNotes)
//                .build()
//            startForeground(5, notification)
//        } else {
//            //Notification panel when the screen is locked
//            //Red
//            val notification: Notification = notificationBuilder
//                .setOngoing(true)
//                .setOnlyAlertOnce(true)
//                .setChannelId(getString(R.string.app_name))
//                .setSmallIcon(R.drawable.ic_launcher_foreground)
//                .setColor(Color.RED)
//                .setContentTitle(getString(R.string.number_of_notes_to_play) + ": " + sp!!.getSharedmPrefNumberOfNotesToPlay())
//                .setPriority(NotificationManager.IMPORTANCE_HIGH)
//                .setCategory(Notification.CATEGORY_SERVICE)
//                .setContentIntent(pendingIntent)
//                .addAction(increaseNotes)
//                .build()
//            startForeground(5, notification)
//        }
//
//        //Updates the tile
//        TileService.requestListeningState(this, ComponentName(this, LockTileService::class.java))
//    }
//
//    class IncrementNumberOfNotes() : Service() {
//        override fun onBind(intent: Intent?): IBinder? {
//            return null
//        }
//
//        override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
//            if (!CheckPermissions().getIsScreenLocked(this)) {
//                val sp = SharedPref(this)
//                val actualNumNotes: Int = sp.getSharedmPrefNumberOfNotesToPlay()!!.toInt()
//                val numIncremented: Int
//                if (actualNumNotes < 8) numIncremented = actualNumNotes + 1 else numIncremented = 1
//                sp.setSharedmPrefNumberOfNotesToPlay(numIncremented.toString())
//            }
//            return super.onStartCommand(intent, flags, startId)
//        }
//    }
}