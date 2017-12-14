module Groups.Update exposing (init, update)

import Common.IdentifiedList exposing (findById, mapIfId)
import Form exposing (Form)
import Groups.Model as Groups exposing (Model, Msg(..), validation)
import Groups.Ports exposing (..)
import Model as Root exposing (Msg(..))
import RemoteData exposing (..)
import Return exposing (Return, command, return)
import UrlRouter.Model exposing (Msg(..))
import UrlRouter.Routes exposing (Page(..), pathParser)


init : Model
init =
    { list = NotAsked
    , new =
        { fields = Form.initial [] validation
        , response = NotAsked
        }
    }


update : Root.Msg -> Model -> Return Groups.Msg Model
update msg model =
    case msg of
        MsgForGroups msg_ ->
            updateGroups msg_ model

        MsgForUrlRouter (UrlChange location) ->
            case pathParser location of
                Just GroupsListPage ->
                    fetchGroups model

                Just (GroupDetailsPage _) ->
                    fetchGroups model

                Just (RidesListPage groupId) ->
                    fetchGroups model
                        |> command (joinRequestsList { groupId = groupId })

                _ ->
                    return model Cmd.none

        _ ->
            return model Cmd.none


updateGroups : Groups.Msg -> Model -> Return Groups.Msg Model
updateGroups msg model =
    let
        new =
            model.new

        fields =
            model.new.fields

        updateFields fields =
            { model | new = { new | fields = fields } }
    in
    case msg of
        UpdateGroups response ->
            return { model | list = response } Cmd.none

        CreateJoinGroupRequest groupId ->
            return
                (updateGroup groupId (\group -> { group | joinRequest = Loading }) model)
                (createJoinGroupRequest { groupId = groupId })

        CreateJoinGroupRequestResponse groupId response ->
            return
                (updateGroup groupId (\group -> { group | joinRequest = response }) model)
                Cmd.none

        JoinRequestsListResponse groupId response ->
            return
                (updateGroup groupId (\group -> { group | joinRequests = response }) model)
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

        FormMsg formMsg ->
            case ( formMsg, Form.getOutput fields ) of
                ( Form.Submit, Just newGroup ) ->
                    return { model | new = { new | response = Loading } } (createGroup newGroup)

                _ ->
                    return { model | new = { new | fields = Form.update validation formMsg fields } } Cmd.none

        CreateGroupResponse response ->
            case response of
                Success _ ->
                    return init Cmd.none

                _ ->
                    return { model | new = { new | response = response } } Cmd.none


fetchGroups : Model -> Return Groups.Msg Model
fetchGroups model =
    if model.list == NotAsked then
        return { model | list = Loading } (groupsList ())
    else
        return model Cmd.none


updateGroup : String -> (Groups.Group -> Groups.Group) -> Model -> Model
updateGroup groupId updateFn model =
    { model
        | list =
            RemoteData.map (mapIfId groupId updateFn identity) model.list
    }


updateJoinRequest : String -> (Groups.JoinRequest -> Groups.JoinRequest) -> Groups.Group -> Groups.Group
updateJoinRequest userId updateFn group =
    { group
        | joinRequests =
            RemoteData.map
                (List.map
                    (\item ->
                        if item.userId == userId then
                            updateFn item
                        else
                            item
                    )
                )
                group.joinRequests
    }
