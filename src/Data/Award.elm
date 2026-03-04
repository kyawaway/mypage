module Data.Award exposing (Award, awards)


type alias Award =
    { title : String
    , venue : String
    , url : Maybe String
    }


awards : List Award
awards =
    [ { title = "Best Student Paper Honorable Mention"
      , venue = "The 27th International Symposium on Practical Aspects of Declarative Languages (PADL 2025)"
      , url = Just "https://popl25.sigplan.org/home/PADL-2025#Awards"
      }
    , { title = "Poster Session Audience Award (Non-SRC)"
      , venue = "The 21st Asian Symposium on Programming Languages and Systems (APLAS 2023)"
      , url = Just "https://conf.researchr.org/track/aplas-2023/src-and-posters?#audience-awards"
      }
    ]
