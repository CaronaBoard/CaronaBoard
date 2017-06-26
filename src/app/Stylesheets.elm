port module Stylesheets exposing (..)

import Css.File exposing (CssCompilerProgram, CssFileStructure)
import Layout.Styles
import Login.Styles
import Notifications.Styles
import RideRequest.Styles
import Rides.Styles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "main.css"
          , Css.File.compile
                [ Layout.Styles.styles
                , Login.Styles.styles
                , Rides.Styles.styles
                , Notifications.Styles.styles
                , RideRequest.Styles.styles
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
