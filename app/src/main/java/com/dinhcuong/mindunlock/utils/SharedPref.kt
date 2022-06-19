package com.dinhcuong.mindunlock.utils

import android.content.Context
import android.content.SharedPreferences
import com.dinhcuong.mindunlock.R

class SharedPref(context: Context) {
    private var mContext: Context? = context
    private var isLocking: SharedPreferences? = null

    init {
        isLocking = mContext!!.getSharedPreferences(
            mContext!!.getString(R.string.is_locking),
            Context.MODE_PRIVATE
        )
    }

    fun getIsLocking(): Boolean {
        return isLocking!!.getBoolean(mContext!!.getString(R.string.is_locking), false)
    }

    fun setIsLocking(b: Boolean?) {
        isLocking!!
            .edit()
            .putBoolean(mContext!!.getString(R.string.is_locking), b!!)
            .apply()
    }

}