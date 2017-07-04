module Common.Response exposing (FirebaseResponse, Response(..), decodeFromFirebase, fromFirebase, fromResult, map)

import Json.Decode as Json exposing (Decoder, decodeValue)


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


decodeFromFirebase : Decoder a -> FirebaseResponse Json.Value -> Response a
decodeFromFirebase decoder response =
    case fromFirebase response of
        Success json ->
            fromResult (decodeValue decoder json)

        Empty ->
            Empty

        Loading ->
            Loading

        Error err ->
            Error err


fromResult : Result x a -> Response a
fromResult result =
    case result of
        Ok data ->
            Success data

        Err err ->
            Error (toString err)
