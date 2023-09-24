package com.example.dnstest.dns_test

import android.content.Context
import android.content.Intent
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json


class ListWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return ListRemoteViewsFactory(this.applicationContext, intent)
    }
}

class ListRemoteViewsFactory(
    private val context: Context,
    private val intent: Intent
) : RemoteViewsService.RemoteViewsFactory {

    private var tasks: List<Task> = emptyList()




    override fun onCreate() {

    }

    override fun onDataSetChanged() {
        tasks = Json.decodeFromString(intent.getStringExtra("task_list") ?: "[]")

    }

    override fun onDestroy() {
    }

    override fun getCount(): Int {
        return tasks.size
    }

    override fun getViewAt(position: Int): RemoteViews {


        val rv = RemoteViews(context.packageName.toString(), R.layout.task_item)
        rv.setTextViewText(R.id.taskName, tasks[position].name)
        rv.setTextViewText(R.id.taskDate, tasks[position].creationDate.toString())
        rv.setTextViewText(R.id.taskStatus, tasks[position].taskStatus.toString())// примерно так

        return rv
    }

    override fun getLoadingView(): RemoteViews? {
        return  null
    }

    override fun getViewTypeCount(): Int {
        return 1
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun hasStableIds(): Boolean {

      return  true
    }

}
