module Common.Response exposing (FirebaseResponse, Response(..), firebaseMap, fromFirebase)


type Response a
    = Empty
    | Loading
    | Success a
    | Error String


type alias FirebaseResponse a =
    ( Maybe String, Maybe a )


fromFirebase : FirebaseResponse a -> Response a
fromFirebase response =
    case response of
        ( Just error, _ ) ->
            Error error

        ( _, Just data ) ->
            Success data

        ( Nothing, Nothing ) ->
            Error "Invalid FirebaseResponse"


firebaseMap : (a -> b) -> FirebaseResponse a -> FirebaseResponse b
firebaseMap f response =
    case response of
        ( err, Just data ) ->
            ( err, Just (f data) )

        ( err, Nothing ) ->
            ( err, Nothing )
