module Login.View.Layout exposing (formStep, loginLayout)

import Common.Icon exposing (icon)
import Html exposing (..)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (Classes(..), className)
import Model as Root exposing (Msg)


loginLayout : Html.Html Root.Msg -> Html.Html Root.Msg
loginLayout child =
    div [ className Page ]
        [ child ]


formStep : Html Login.Model.Msg -> Html Login.Model.Msg
formStep step =
    div [ className Background ]
        [ div
            [ className Container ]
            [ div [ className StepTitle ]
                [ h1 []
                    [ b [] [ text "Carona" ]
                    , text "Board"
                    ]
                , p []
                    [ text "O CaronaBoard é um aplicativo de grupos de caronas, descubra quem está indo para o mesmo lugar que você e dê ou peça uma carona"
                    ]
                ]
            , div [ className StepForm ]
                [ div [ className Icon ]
                    [ div [] [ icon "lock_outline" ]
                    , text "Entre com sua conta"
                    ]
                , step
                ]
            ]
        ]
