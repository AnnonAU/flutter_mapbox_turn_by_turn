package au.com.annon.flutter_mapbox_turn_by_turn.ui

import android.view.View
import android.content.Context
import android.util.Log

import au.com.annon.flutter_mapbox_turn_by_turn.databinding.TurnByTurnActivityBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView


internal class TurnByTurnView(
        context: Context,
        binding: TurnByTurnActivityBinding,
        messenger: BinaryMessenger,
        id: Int,
        creationParams: Map<String?, Any?>?,
    )
    : PlatformView, TurnByTurnActivity(context, binding, creationParams) {
    private val id: Int = id
    private val messenger: BinaryMessenger = messenger

    override fun getView(): View {
        return getBinding().root
    }

    init {
        initializeFlutterChannelHandlers()
        initializeActivity()
        Log.d("TurnByTurnView", "View initialised")
    }

    override fun onFlutterViewAttached(flutterView: View) {
        super.onFlutterViewAttached(flutterView)
        Log.d("TurnByTurnView", "View attached")
    }

    override fun onFlutterViewDetached() {
        detachActivity()
        super.onFlutterViewDetached()
        Log.d("TurnByTurnView", "View detached")
    }

    override fun dispose() {
        destroy()
        Log.d("TurnByTurnView", "View disposed")
    }

    override fun initializeFlutterChannelHandlers() {
        methodChannel = MethodChannel(messenger, "flutter_mapbox_turn_by_turn/map_view/method")
        eventChannel = EventChannel(messenger, "flutter_mapbox_turn_by_turn/map_view/events")
        super.initializeFlutterChannelHandlers()
    }
}
