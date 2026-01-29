module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import Data.Award as Award
import Data.Education as Education
import Data.Profile as Profile
import Data.Publication as Publication
import Data.ResearchInterest as ResearchInterest
import Data.Tool as Tool
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Pages.Url
import PagesMsg exposing (PagesMsg)
import RouteBuilder exposing (App, StatefulRoute)
import Shared
import View exposing (View)


type alias Filters =
    { featured : Bool
    , refereed : Bool
    , journal : Bool
    , proceedings : Bool
    }


type alias Model =
    { filters : Filters
    }


type Msg
    = ToggleFilter FilterType


type FilterType
    = Featured
    | Refereed
    | Journal
    | Proceedings


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatefulRoute RouteParams Data ActionData Model Msg
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildWithLocalState
            { init = init
            , update = update
            , subscriptions = \_ _ _ _ -> Sub.none
            , view = view
            }


init : App Data ActionData RouteParams -> Shared.Model -> ( Model, Effect Msg )
init _ _ =
    ( { filters = { featured = True, refereed = False, journal = False, proceedings = False } }
    , Effect.none
    )


update : App Data ActionData RouteParams -> Shared.Model -> Msg -> Model -> ( Model, Effect Msg )
update _ _ msg model =
    case msg of
        ToggleFilter filterType ->
            let
                filters =
                    model.filters

                newFilters =
                    case filterType of
                        Featured ->
                            { filters | featured = not filters.featured }

                        Refereed ->
                            { filters | refereed = not filters.refereed }

                        Journal ->
                            { filters | journal = not filters.journal }

                        Proceedings ->
                            { filters | proceedings = not filters.proceedings }
            in
            ( { model | filters = newFilters }
            , Effect.none
            )


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
        , description = Profile.profile.subtitle
        , locale = Nothing
        , title = Profile.profile.name
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> Model
    -> View (PagesMsg Msg)
view _ _ model =
    { title = Profile.profile.name
    , body =
        [ div [ id "page", class "animated fadeIn" ]
            [ -- Hero section
              div [ id "hero-section" ]
                [ div [ id "main-icon", class "main-icon" ]
                    [ img
                        [ src "/favicon-32x32.png"
                        , width 150
                        , height 150
                        , alt "icon"
                        ]
                        []
                    ]
                , h1 [ id "home-title" ] [ text Profile.profile.name ]
                , p [ id "home-subtitle" ] [ text Profile.profile.subtitle ]
                , div [ id "home-social" ]
                    [ viewSocialLink Profile.profile.twitterUrl "twitter" twitterIcon
                    , viewSocialLink Profile.profile.githubUrl "github" githubIcon
                    ]
                , p [ id "home-links" ]
                    [ a [ href "/publication-list" ] [ text "Simple Publication List" ]
                    ]
                ]

            -- Content section
            , main_ [ class "site-main section-inner" ]
                [ article [ class "thin" ]
                    [ div [ class "content" ]
                        [ p [] [ text Profile.profile.bio ]
                        , viewEducation
                        , viewResearchInterest
                        , viewPublications model.filters
                        , viewAwards
                        , viewTools
                        ]
                    ]
                ]

            -- Footer
            , footer [ id "site-footer", class "section-inner thin" ]
                [ p []
                    [ text "\u{00A9} 2025 "
                    , text "Made with "
                    , a [ href "https://elm-pages.com", target "_blank", rel "noopener" ] [ text "elm-pages" ]
                    ]
                ]
            ]
        ]
    }


viewSocialLink : String -> String -> Html msg -> Html msg
viewSocialLink url titleText icon =
    a
        [ href url
        , target "_blank"
        , rel "noopener me"
        , title titleText
        ]
        [ icon ]



-- About content


viewEducation : Html msg
viewEducation =
    div []
        [ h2 [ id "education" ] [ text "Education" ]
        , div [] (List.map viewEducationEntry Education.educations)
        ]


viewEducationEntry : Education.Education -> Html msg
viewEducationEntry edu =
    div []
        [ p []
            [ text edu.period
            , if edu.degree /= "" then
                text (": " ++ edu.degree)

              else
                text ""
            ]
        , ul []
            [ li []
                ([ text edu.description ]
                    ++ (case ( edu.supervisorName, edu.supervisorUrl ) of
                            ( Just name, Just url ) ->
                                [ text ", Supervisor: Professor "
                                , a [ href url, target "_blank" ] [ text name ]
                                , text "."
                                ]

                            _ ->
                                []
                       )
                )
            ]
        ]


viewResearchInterest : Html msg
viewResearchInterest =
    div []
        [ h2 [ id "research-interest" ] [ text "Research Interest" ]
        , ul []
            (List.map viewResearchInterestItem ResearchInterest.researchInterests)
        ]


viewResearchInterestItem : ResearchInterest.ResearchInterest -> Html msg
viewResearchInterestItem interest =
    li []
        ([ text interest.category ]
            ++ (if List.isEmpty interest.items then
                    []

                else
                    [ ul []
                        (List.map (\item -> li [] [ text item ]) interest.items)
                    ]
               )
        )


viewPublications : Filters -> Html (PagesMsg Msg)
viewPublications filters =
    let
        allPublications =
            List.map (\p -> ( "Refereed", p )) Publication.refereedPapers
                ++ List.map (\p -> ( "Unrefereed", p )) Publication.unrefereedPapers
                ++ List.map (\p -> ( "Poster", p )) Publication.posters

        sortedPublications =
            List.sortBy (\( _, p ) -> negate (Maybe.withDefault 0 (String.toInt p.year))) allPublications

        noFiltersSelected =
            not filters.featured && not filters.refereed && not filters.journal && not filters.proceedings

        filteredPublications =
            if noFiltersSelected then
                sortedPublications

            else
                List.filter (matchesFilters filters) sortedPublications
    in
    div []
        [ h2 [ id "publications" ] [ text "Publications" ]
        , viewFilterButtons filters
        , if List.isEmpty filteredPublications then
            p [ class "no-results" ] [ text "No publications match the selected filters." ]

          else
            div [ class "publication-cards" ]
                (List.map viewPublicationCard filteredPublications)
        ]


matchesFilters : Filters -> ( String, Publication.Publication ) -> Bool
matchesFilters filters ( pubType, pub ) =
    let
        matchesFeatured =
            not filters.featured || pub.featured

        matchesRefereed =
            not filters.refereed || pubType == "Refereed"

        matchesJournal =
            not filters.journal || pub.category == Publication.Journal

        matchesProceedings =
            not filters.proceedings || (pub.category == Publication.Proceedings && pubType /= "Poster")
    in
    matchesFeatured && matchesRefereed && matchesJournal && matchesProceedings


viewFilterButtons : Filters -> Html (PagesMsg Msg)
viewFilterButtons filters =
    div [ class "filter-buttons" ]
        [ viewFilterButton Featured "Featured" filters.featured
        , viewFilterButton Refereed "Refereed" filters.refereed
        , viewFilterButton Journal "Journal" filters.journal
        , viewFilterButton Proceedings "Proceedings" filters.proceedings
        ]


viewFilterButton : FilterType -> String -> Bool -> Html (PagesMsg Msg)
viewFilterButton filterType label isActive =
    button
        [ class
            (if isActive then
                "filter-btn filter-btn-active"

             else
                "filter-btn"
            )
        , onClick (PagesMsg.fromMsg (ToggleFilter filterType))
        ]
        [ text label ]


viewPublicationCard : ( String, Publication.Publication ) -> Html msg
viewPublicationCard ( pubType, pub ) =
    div [ class "publication-card" ]
        [ div [ class "card-header" ]
            [ h3 [ class "card-title" ]
                [ case pub.url of
                    Just url ->
                        a [ href url, target "_blank" ] [ text pub.title ]

                    Nothing ->
                        text pub.title
                ]
            , div [ class "card-badges" ]
                ([ span [ class ("card-badge " ++ badgeClass pubType) ] [ text pubType ] ]
                    ++ (if pubType == "Poster" then
                            []

                        else
                            [ span [ class ("card-badge " ++ categoryBadgeClass pub.category) ] [ text (categoryToString pub.category) ] ]
                       )
                )
            ]
        , div [ class "card-meta" ] [ text pub.authors ]
        , div [ class "card-venue" ] [ text pub.venue ]
        , if List.isEmpty pub.links then
            text ""

          else
            div [ class "card-links" ]
                (List.map viewCardLink pub.links)
        ]


categoryToString : Publication.Category -> String
categoryToString cat =
    case cat of
        Publication.Journal ->
            "Journal"

        Publication.Proceedings ->
            "Proceeding"


categoryBadgeClass : Publication.Category -> String
categoryBadgeClass cat =
    case cat of
        Publication.Journal ->
            "badge-journal"

        Publication.Proceedings ->
            "badge-proceedings"


badgeClass : String -> String
badgeClass pubType =
    case pubType of
        "Refereed" ->
            "badge-refereed"

        "Unrefereed" ->
            "badge-unrefereed"

        "Poster" ->
            "badge-poster"

        _ ->
            ""


viewCardLink : ( String, String ) -> Html msg
viewCardLink ( label, url ) =
    a [ href url, target "_blank", class "card-link" ] [ text label ]


viewAwards : Html msg
viewAwards =
    div []
        [ h2 [ id "awards" ] [ text "Awards" ]
        , div [ class "award-cards" ]
            (List.map viewAwardCard Award.awards)
        ]


viewAwardCard : Award.Award -> Html msg
viewAwardCard award =
    div [ class "award-card" ]
        [ h3 [ class "card-title" ]
            [ case award.url of
                Just url ->
                    a [ href url, target "_blank" ] [ text award.title ]

                Nothing ->
                    text award.title
            ]
        , div [ class "card-venue" ] [ text award.venue ]
        ]


viewTools : Html msg
viewTools =
    div []
        [ h2 [ id "tools" ] [ text "Tools" ]
        , div [ class "tool-cards" ]
            (List.map viewToolCard Tool.tools)
        ]


viewToolCard : Tool.Tool -> Html msg
viewToolCard tool =
    div [ class "tool-card" ]
        [ h3 [ class "card-title" ]
            [ a [ href tool.url, target "_blank" ] [ text tool.name ] ]
        , div [ class "card-description" ] [ text tool.description ]
        , div [ class "card-links" ]
            [ a [ href tool.url, target "_blank", class "card-link" ]
                [ text "Website" ]
            , a [ href tool.githubUrl, target "_blank", class "card-link" ]
                [ Html.i [ class "fa-brands fa-github" ] []
                , text " GitHub"
                ]
            ]
        ]



-- Font Awesome Icons


twitterIcon : Html msg
twitterIcon =
    Html.i [ class "fa-brands fa-twitter" ] []


githubIcon : Html msg
githubIcon =
    Html.i [ class "fa-brands fa-github" ] []
