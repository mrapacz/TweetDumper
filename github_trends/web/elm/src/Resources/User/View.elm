module Resources.User.View exposing (listUsers, usersView)

import Html exposing (..)
import Html.Attributes exposing (class, href, placeholder, src)
import Html.Events exposing (onClick, onInput)
import Msgs exposing (Msg(MkUsersMsg))
import Resources.Common.Models exposing (orderOptions)
import Resources.User.Models exposing (UserRecord, sortUsersOptions)
import Resources.User.Msgs exposing (UsersMessage(FetchUsers, NewFollowersUsers, NewOrderUsersOption, NewReposUsers, NewSortUsersOption))
import Select


listUsers : List UserRecord -> Html Msg
listUsers users =
    ul [] (List.map displayUser users)


displayUser : UserRecord -> Html Msg
displayUser user =
    div [ class "list-element" ]
        [ h4 [] [ text user.login ]
        , li [] [ text <| "User url: ", a [ href user.html_url ] [ text user.html_url ] ]
        , li [] [ img [ src user.avatar_url ] [] ]
        , li [] [ text <| "User score: " ++ (toString user.score) ]
        ]


usersInputView : Html Msg
usersInputView =
    let
        inputList =
            [ input [ placeholder "Repos number", onInput NewReposUsers ] []
            , input [ placeholder "Followers number", onInput NewFollowersUsers ] []
            , Select.from sortUsersOptions NewSortUsersOption
            , Select.from orderOptions NewOrderUsersOption
            , button [ onClick FetchUsers ] [ text "Submit" ]
            ]
    in
        div [] (List.map (Html.map MkUsersMsg) inputList)


usersView : Html Msg
usersView =
    div [ class "content-section" ]
        [ h3 [] [ text "Users:" ]
        , usersInputView
        ]
