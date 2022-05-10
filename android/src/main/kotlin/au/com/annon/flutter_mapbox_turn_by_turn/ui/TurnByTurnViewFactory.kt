package au.com.annon.flutter_mapbox_turn_by_turn.ui

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.*

import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TurnByTurnViewFactory(
        private val applicationContext: Context,
        private val messenger: BinaryMessenger,
        private val activity: Activity
    )
    : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return TurnByTurnView(applicationContext, messenger, viewId, creationParams)
    }
}