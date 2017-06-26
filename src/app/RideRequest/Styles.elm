module RideRequest.Styles exposing (Classes(..), class, namespace, styles)

import Common.CssHelpers exposing (..)
import Css exposing (..)
import Css.Namespace


{ class, namespace } =
    withNamespace "rideRequest"


type Classes
    = Contact


styles : Stylesheet
styles =
    (stylesheet << Css.Namespace.namespace namespace)
        [ cssClass Contact
            [ fontSize (px 24)
            ]
        ]
