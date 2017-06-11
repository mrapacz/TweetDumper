module Resources.User.Api exposing (..)

import Http
import Json.Decode as Decode exposing (null, oneOf)
import Models exposing (Hostname, getHost)
import Resources.Common.Api exposing (buildUrl)
import Resources.User.Models exposing (UserParams, UserRecord)
import Msgs exposing (Msg)
import Resources.User.Msgs exposing (UsersMessage(LoadUsersData))
import String exposing (toLower)


getUsersData : Hostname -> UserParams -> Http.Request (List UserRecord)
getUsersData hostname params =
    let
        paramsList =
            [ ( "repos", params.repos )
            , ( "followers", params.followers )
            , ( "sort", toLower <| toString <| params.sort )
            , ( "order", toLower <| toString <| params.order )
            ]

        url =
            buildUrl hostname "users" paramsList
    in
        Http.get url decodeUsersList


decodeUsersRecord : Decode.Decoder UserRecord
decodeUsersRecord =
    Decode.map4 UserRecord
        (Decode.field "score" Decode.int)
        (Decode.field "login" Decode.string)
        (Decode.field "html_url" Decode.string)
        (Decode.field "avatar_url" Decode.string)


decodeUsersList : Decode.Decoder (List UserRecord)
decodeUsersList =
    Decode.list decodeUsersRecord


requestUsersData : Hostname -> UserParams -> Cmd UsersMessage
requestUsersData hostname params =
    Http.send LoadUsersData (getUsersData hostname params)
