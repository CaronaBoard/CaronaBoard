module Fuzz.UrlRouter.UpdateSpec exposing (..)

import Array exposing (Array, fromList, get, length)
import Expect exposing (equal)
import Fuzz exposing (Fuzzer)
import Helpers exposing (fixtures, someUser, toLocation)
import Login.Model as Login
import Navigation exposing (Location)
import Profile.Model
import Test exposing (..)
import UrlRouter.Routes exposing (Page(..), pathParser, redirectTo, toPath)
import UrlRouter.Update exposing (changePageTo)


tests : Test
tests =
    describe "UrlRouter"
        [ describe "changePageTo"
            [ fuzz3 randomPage randomLogin randomPage "returns the requested page redirect unless the current page, the requested one and the redirect to are all the same" <|
                \currentPage login requestedPage ->
                    let
                        pageToRedirect =
                            redirectTo profileSample login requestedPage

                        pageToGo =
                            changePageTo profileSample login { page = currentPage } (toLocation requestedPage)
                    in
                    if currentPage == pageToRedirect && currentPage == requestedPage then
                        Expect.equal Nothing pageToGo
                    else
                        Expect.equal (Just pageToRedirect) pageToGo
            , fuzz2 randomLogin randomPath "returns 404 for random paths" <|
                \login randomPath ->
                    let
                        pageToGo =
                            changePageTo profileSample login { page = SplashScreenPage } (pathToLocation randomPath)
                    in
                    Expect.equal (Just NotFoundPage) pageToGo
            ]
        ]


profileSample : Profile.Model.Model
profileSample =
    Profile.Model.init (Just fixtures.profile)


pages : Array Page
pages =
    fromList [ SplashScreenPage, LoginPage, RidesPage, NotFoundPage ]


randomPage : Fuzzer Page
randomPage =
    Fuzz.intRange 0 (length pages - 1)
        |> Fuzz.map (\index -> get index pages)
        |> Fuzz.map (Maybe.withDefault NotFoundPage)


pathToLocation : String -> Location
pathToLocation path =
    { href = "", host = "", hostname = "", protocol = "", origin = "", port_ = "", pathname = "", search = "", hash = path, username = "", password = "" }


randomLogin : Fuzzer Login.Model
randomLogin =
    Fuzz.map
        (\bool ->
            if bool then
                Login.init someUser
            else
                Login.init Nothing
        )
        Fuzz.bool


randomPath : Fuzzer String
randomPath =
    Fuzz.map
        (\path ->
            if pathParser (pathToLocation path) == Just SplashScreenPage then
                "foo"
            else
                path
        )
        Fuzz.string
