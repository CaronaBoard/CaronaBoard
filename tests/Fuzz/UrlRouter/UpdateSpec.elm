module Fuzz.UrlRouter.UpdateSpec exposing (..)

import Test exposing (..)
import Expect exposing (equal)
import Fuzz exposing (Fuzzer)
import UrlRouter.Update exposing (changePageTo)
import UrlRouter.Routes exposing (Page(..), toPath, redirectTo)
import Array exposing (Array, fromList, get, length)
import Navigation exposing (Location)
import Login.Model as Login


tests : Test
tests =
    describe "UrlRouter"
        [ describe "changePageTo"
            [ fuzz3 randomPage randomLogin randomPage "returns the requested page redirect unless the current page, the requested one and the redirect to are all the same" <|
                \currentPage login requestedPage ->
                    let
                        pageToRedirect =
                            redirectTo login requestedPage

                        pageToGo =
                            changePageTo { page = currentPage } login (toLocation requestedPage)
                    in
                        if currentPage == pageToRedirect && currentPage == requestedPage then
                            Expect.equal Nothing pageToGo
                        else
                            Expect.equal (Just pageToRedirect) pageToGo
            , fuzz2 randomLogin randomPath "returns 404 for random paths" <|
                \login randomPath ->
                    let
                        pageToGo =
                            changePageTo { page = HomeRoute } login (pathToLocation randomPath)
                    in
                        Expect.equal (Just NotFound) pageToGo
            ]
        ]


pages : Array Page
pages =
    fromList [ HomeRoute, LoginRoute, RidesRoute, NotFound ]


randomPage : Fuzzer Page
randomPage =
    Fuzz.intRange 0 (length pages - 1)
        |> Fuzz.map (\index -> get index pages)
        |> Fuzz.map (Maybe.withDefault NotFound)


pathToLocation : String -> Location
pathToLocation path =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = path, username = "", password = "" }


toLocation : Page -> Location
toLocation =
    toPath >> pathToLocation


randomLogin : Fuzzer Login.Model
randomLogin =
    Fuzz.map
        (\bool ->
            if bool then
                Login.init (Just { id = "foo", name = "bar" })
            else
                Login.init Nothing
        )
        Fuzz.bool


randomPath : Fuzzer String
randomPath =
    Fuzz.map
        (\path ->
            if String.isEmpty path then
                "foo"
            else
                path
        )
        Fuzz.string
