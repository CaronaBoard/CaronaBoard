module Common.Response exposing (FirebaseResponse, Response(..), fromFirebase, map)


type Response a
    = Empty
    | Loading
    | Success a
    | Error String


type alias FirebaseResponse a =
    ( Maybe String, Maybe a )


map : (a -> b) -> Response a -> Response b
map f response =
    case response of
        Success a ->
            Success (f a)

        Empty ->
            Empty

        Loading ->
            Loading

        Error err ->
            Error err


fromFirebase : FirebaseResponse a -> Response a
fromFirebase response =
    case response of
        ( Just error, _ ) ->
            Error error

        ( _, Just data ) ->
            Success data

        ( Nothing, Nothing ) ->
            Error "Invalid FirebaseResponse"
