module Login.View.Layout exposing (formStep, loginLayout)

import Common.Icon exposing (icon)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Login.Model exposing (Model, Msg(..))
import Login.Styles exposing (..)
import Model as Root exposing (Msg)


loginLayout : Html Root.Msg -> Html Root.Msg
loginLayout child =
    styled div
        page
        [ id "loginPage" ]
        [ child ]


formStep : Html Login.Model.Msg -> Html Login.Model.Msg
formStep step =
    styled div
        background
        []
        [ styled div
            container
            []
            [ styled div
                stepTitle
                []
                [ h1 []
                    [ b [] [ text "Carona" ]
                    , text "Board"
                    ]
                , p []
                    [ text "O CaronaBoard é um aplicativo de grupos de caronas, descubra quem está indo para o mesmo lugar que você e dê ou peça uma carona"
                    ]
                ]
            , styled div
                stepForm
                []
                [ styled div
                    Login.Styles.icon
                    []
                    [ styled div bigIcon [] [ Html.Styled.fromUnstyled <| Common.Icon.icon "lock_outline" ]
                    , text "Entre com sua conta"
                    ]
                , step
                ]
            ]
        ]
