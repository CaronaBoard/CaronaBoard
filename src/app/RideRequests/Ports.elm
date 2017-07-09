port module RideRequests.Ports exposing (fetchRideRequest)


port fetchRideRequest :
    { groupId : String
    , rideId : String
    , userId : String
    , rideRequestId : String
    }
    -> Cmd msg
