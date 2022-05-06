package au.com.annon.flutter_mapbox_turn_by_turn.models

import au.com.annon.flutter_mapbox_turn_by_turn.ui.TurnByTurnActivity
import com.google.gson.Gson

enum class MapboxEventType(val value: String) {
    PROGRESS_CHANGE("progressChange"),
    LOCATION_CHANGE("locationChange"),
    MAP_READY("mapReady"),
    ROUTE_BUILDING("routeBuilding"),
    ROUTE_BUILT("routeBuilt"),
    ROUTE_BUILD_FAILED("routeBuildFailed"),
    ROUTE_BUILD_CANCELLED("routeBuildCancelled"),
    ROUTE_BUILD_NO_ROUTES_FOUND("routeBuildNoRoutesFound"),
    USER_OFF_ROUTE("userOffRoute"),
    MILESTONE_EVENT("milestoneEvent"),
    NAVIGATION_RUNNING("navigationRunning"),
    NAVIGATION_CANCELLED("navigationCancelled"),
    NAVIGATION_FINISHED("navigationFinished"),
    FASTER_ROUTE_FOUND("fasterRouteFound"),
    SPEECH_ANNOUNCEMENT("speechAnnouncement"),
    BANNER_INSTRUCTION("bannerInstruction"),
    WAYPOINT_ARRIVAL("waypointArrival"),
    NEXT_ROUTE_LEG_START("nextRouteLegStart"),
    FINAL_DESTINATION_ARRIVAL("finalDestinationArrival"),
    FAILED_TO_REROUTE("failedToReroute"),
    REROUTE_ALONG("rerouteAlong"),
}

class MapboxTurnByTurnEvents {
    companion object {
        fun sendEvent(event: MapboxProgressChangeEvent) {
            val dataString = Gson().toJson(event)
            val jsonString = "{" +
                    "  \"eventType\": \"${MapboxEventType.PROGRESS_CHANGE.value}\"," +
                    "  \"data\": $dataString" +
                    "}"
            TurnByTurnActivity.eventSink?.success(jsonString)
        }

        fun sendEvent(event: MapboxLocationChangeEvent) {
            val dataString = Gson().toJson(event)
            val jsonString = "{" +
                    "  \"eventType\": \"${MapboxEventType.LOCATION_CHANGE.value}\"," +
                    "  \"data\": $dataString" +
                    "}"
            TurnByTurnActivity.eventSink?.success(jsonString)
        }

        fun sendEvent(event: MapboxEventType, data: String = "") {
            val jsonString =
                if (event == MapboxEventType.MILESTONE_EVENT || event == MapboxEventType.USER_OFF_ROUTE) "{" +
                        "  \"eventType\": \"${event.value}\"," +
                        "  \"data\": $data" +
                        "}" else "{" +
                        "  \"eventType\": \"${event.value}\"," +
                        "  \"data\": \"$data\"" +
                        "}"
            TurnByTurnActivity.eventSink?.success(jsonString)
        }
    }
}
