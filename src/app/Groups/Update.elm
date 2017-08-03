module Groups.Update exposing (init, update)

import Common.IdentifiedList exposing (mapIfId)
import Common.Response as Response exposing (Response(..))
import Groups.Model as Groups exposing (Model, Msg(..))
import Groups.Ports exposing (createJoinGroupRequest, groupsList, respondJoinRequest)
import Model as Root exposing (Msg(..))
import Return exposing (Return, return)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    { groups = Empty }


update : Root.Msg -> Model -> Return Groups.Msg Model
update msg model =
    case msg of
        MsgForGroups msg_ ->
            updateGroups msg_ model

        MsgForUrlRouter (UrlChange location) ->
            if model.groups == Empty && pathParser location == Just GroupsListPage then
                return { model | groups = Loading } (groupsList ())
            else
                return model Cmd.none

        _ ->
            return model Cmd.none


updateGroups : Groups.Msg -> Model -> Return Groups.Msg Model
updateGroups msg model =
    case msg of
        UpdateGroups response ->
            return { model | groups = response } Cmd.none

        CreateJoinGroupRequest groupId ->
            return
                (updateGroup groupId (\group -> { group | joinRequest = Loading }) model)
                (createJoinGroupRequest { groupId = groupId })

        CreateJoinGroupRequestResponse groupId response ->
            return
                (updateGroup groupId (\group -> { group | joinRequest = response }) model)
                Cmd.none

        RespondJoinRequest groupId userId accepted ->
            return
                (updateGroup groupId
                    (updateJoinRequest userId
                        (\joinRequest -> { joinRequest | response = Loading })
                    )
                    model
                )
                (respondJoinRequest { groupId = groupId, userId = userId, accepted = accepted })

        RespondJoinRequestResponse groupId userId response ->
            return
                (updateGroup groupId
                    (updateJoinRequest userId
                        (\joinRequest -> { joinRequest | response = response })
                    )
                    model
                )
                Cmd.none


updateGroup : String -> (Groups.Group -> Groups.Group) -> Model -> Model
updateGroup groupId updateFn model =
    { model
        | groups =
            Response.map (mapIfId groupId updateFn identity) model.groups
    }


updateJoinRequest : String -> (Groups.JoinRequest -> Groups.JoinRequest) -> Groups.Group -> Groups.Group
updateJoinRequest userId updateFn group =
    { group
        | joinRequests =
            List.map
                (\item ->
                    if item.userId == userId then
                        updateFn item
                    else
                        item
                )
                group.joinRequests
    }
