port module Stylesheets exposing (..)

import Css.File exposing (CssCompilerProgram, CssFileStructure)
import Groups.Styles
import Layout.Styles
import Login.Styles
import Notifications.Styles
import Profile.Styles
import Rides.Ride.Styles
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
                , Rides.Ride.Styles.styles
                , Profile.Styles.styles
                , Groups.Styles.styles
                ]
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
