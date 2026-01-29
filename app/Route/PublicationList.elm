module Route.PublicationList exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Data.Award as Award
import Data.Profile as Profile
import Data.Publication as Publication
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (..)
import Html.Attributes exposing (..)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed {}


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head _ =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = Profile.profile.name
        , image =
            { url = Pages.Url.external "https://www.ueda.info.waseda.ac.jp/~takyu/favicon-32x32.png"
            , alt = Profile.profile.name
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Publication List"
        , locale = Nothing
        , title = "Publication List - " ++ Profile.profile.name
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view _ _ =
    { title = "Publication List - " ++ Profile.profile.name
    , body =
        [ div [ id "page", class "animated fadeIn" ]
            [ div [ class "publication-list-page" ]
                [ header [ class "pub-list-header" ]
                    [ h1 [] [ text Profile.profile.name ]
                    , p [ class "pub-list-back" ]
                        [ a [ href "/" ] [ text "Back to Home" ]
                        ]
                    ]
                , main_ [ class "pub-list-content" ]
                    [ section []
                        [ h2 [] [ text "Experience" ]
                        , ul []
                            [ li [] [ text "April 2025 – current: Researcher at Japanese tech company." ]
                            , li [] [ text "April 2023 – March 2025: Master of Engineering, Waseda University." ]
                            , li [] [ text "April 2019 – March 2023: Bachelor of Engineering, Waseda University." ]
                            ]
                        ]
                    , section []
                        [ h2 [] [ text "Publications" ]
                        , h3 [] [ text "Refereed Publications" ]
                        , ol [ class "pub-list", attribute "reversed" "" ]
                            (List.map viewPubListItem Publication.refereedPapers)
                        , h3 [] [ text "Unrefereed Publications" ]
                        , ol [ class "pub-list", attribute "reversed" "" ]
                            (List.map viewPubListItem Publication.unrefereedPapers)
                        , h3 [] [ text "Posters" ]
                        , ol [ class "pub-list", attribute "reversed" "" ]
                            (List.map viewPubListItem Publication.posters)
                        ]
                    , section []
                        [ h2 [] [ text "Awards" ]
                        , ul []
                            (List.map viewAwardItem Award.awards)
                        ]
                    ]
                , footer [ class "pub-list-footer" ]
                    [ p []
                        [ text "© 2025 "
                        , text Profile.profile.name
                        ]
                    ]
                ]
            ]
        ]
    }


viewPubListItem : Publication.Publication -> Html msg
viewPubListItem pub =
    li [ class "pub-list-item" ]
        [ p []
            ([ text pub.authors
             , text ", \""
             ]
                ++ (case pub.url of
                        Just url ->
                            [ a [ href url, target "_blank" ] [ text pub.title ] ]

                        Nothing ->
                            [ text pub.title ]
                   )
                ++ [ text "\", "
                   , em [] [ text pub.venue ]
                   , text "."
                   ]
                ++ (if List.isEmpty pub.links then
                        []

                    else
                        [ text " " ]
                            ++ List.intersperse (text " ")
                                (List.map viewPubLink pub.links)
                   )
            )
        ]


viewPubLink : ( String, String ) -> Html msg
viewPubLink ( label, url ) =
    a [ href url, target "_blank", class "pub-link" ] [ text ("[" ++ label ++ "]") ]


viewAwardItem : Award.Award -> Html msg
viewAwardItem award =
    li []
        [ case award.url of
            Just url ->
                a [ href url, target "_blank" ] [ text award.title ]

            Nothing ->
                text award.title
        , text (", " ++ award.venue ++ ".")
        ]
