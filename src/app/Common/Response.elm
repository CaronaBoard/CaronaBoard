module Common.Response
    exposing
        ( FirebaseResponse
        , Response
        , decodeFromFirebase
        , fromFirebase
        )

import Json.Decode as Json exposing (Decoder, decodeValue)
import RemoteData exposing (..)


type alias Response a =
    RemoteData String a


type alias FirebaseResponse a =
    ( Maybe String, Maybe a )


fromFirebase : FirebaseResponse a -> Response a
fromFirebase response =
    case response of
        ( Just error, _ ) ->
            Failure error

        ( _, Just data ) ->
            Success data

        ( Nothing, Nothing ) ->
            Failure "Invalid FirebaseResponse"


decodeFromFirebase : Decoder a -> FirebaseResponse Json.Value -> Response a
decodeFromFirebase decoder response =
    case fromFirebase response of
        Success json ->
            fromResult (decodeValue decoder json)

        NotAsked ->
            NotAsked

        Loading ->
            Loading

        Failure err ->
            Failure err
