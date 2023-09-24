package com.example.dnstest.dns_test

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

/**
 * Implementation of App Widget functionality.
 */
class NewAppWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {

        val widgetData = HomeWidgetPlugin.getData(context)

        val tasks = widgetData.getString("task_list","[]")

        val tasksList: List<Task> = Json.decodeFromString(tasks ?: "[]")



        for (appWidgetId in appWidgetIds) {

            updateAppWidget(context, appWidgetManager, appWidgetId,tasksList.filter { it.taskStatus == TaskStatus.open })
        }
    }

    override fun onEnabled(context: Context) {

    }

    override fun onDisabled(context: Context) {

    }
}

internal fun updateAppWidget(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int,
    tasks :List<Task>
) {
    val views = RemoteViews(context.packageName, R.layout.list_layout)
    val intent = Intent(context, ListWidgetService::class.java)
    intent.putExtra("task_list",Json.encodeToString(tasks))
    intent.data = Uri.parse(intent.toUri(Intent.URI_INTENT_SCHEME) + System.currentTimeMillis())

    if(tasks.isEmpty() ) { views.setViewVisibility(R.id.emptyText, View.VISIBLE)} else{
        views.setViewVisibility(R.id.emptyText, View.GONE)
    }

    views.setRemoteAdapter(R.id.taskListView, intent)

    appWidgetManager.updateAppWidget(appWidgetId, views)
    appWidgetManager.notifyAppWidgetViewDataChanged(appWidgetId,R.layout.list_layout)
}