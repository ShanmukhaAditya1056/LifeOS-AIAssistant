package com.lifeos.assistant

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED || intent.action == "android.intent.action.QUICKBOOT_POWERON") {
            Log.d("LifeOS", "Device reboot detected. Rescheduling alarms from Drift DB.")
            // In production, invoke a background service or Flutter headless engine
            // to query Drift SQLite and reschedule pending alarms.
        }
    }
}
